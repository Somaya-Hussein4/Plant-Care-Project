import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

class UserDeviceService {
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _messaging;

  UserDeviceService({
    FirebaseFirestore? firestore,
    FirebaseMessaging? messaging,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _messaging = messaging ?? FirebaseMessaging.instance;

  Future<void> initAndSaveUserDevice(String userId) async {
    await Future.wait([
      _saveToken(userId),
      _saveLocation(userId),
    ]);
  }

  Future<void> _saveToken(String userId) async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final token = await _messaging.getToken();
    if (token == null) return;

    await _firestore.collection('users').doc(userId).set(
      {'fcmToken': token},
      SetOptions(merge: true),
    );

    _messaging.onTokenRefresh.listen((newToken) {
      _firestore.collection('users').doc(userId).set(
        {'fcmToken': newToken},
        SetOptions(merge: true),
      );
    });
  }

  Future<void> _saveLocation(String userId) async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      // Use stream instead of one-shot — more reliable on emulators
      final completer = Completer<Position>();

      final sub = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          distanceFilter: 0,
        ),
      ).listen(
        (position) {
          if (!completer.isCompleted) {
            completer.complete(position);
          }
        },
        onError: (e) {
          if (!completer.isCompleted) {
            completer.completeError(e);
          }
        },
      );

      try {
        // wait max 10 seconds for first position from stream
        final position = await completer.future.timeout(
          const Duration(seconds: 10),
        );

        await sub.cancel();

        await _savePositionToFirestore(
            userId, position.latitude, position.longitude);
      } on TimeoutException {
        await sub.cancel();
      }
    } catch (e, stack) {}
  }

  Future<void> _savePositionToFirestore(
      String userId, double lat, double lng) async {
    await _firestore.collection('users').doc(userId).set(
      {'latitude': lat, 'longitude': lng},
      SetOptions(merge: true),
    );
  }
}
