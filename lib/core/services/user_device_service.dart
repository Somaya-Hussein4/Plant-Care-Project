import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

/// Call this once after the user logs in (or on app start if already logged in).
class UserDeviceService {
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _messaging;

  UserDeviceService({
    FirebaseFirestore? firestore,
    FirebaseMessaging? messaging,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _messaging = messaging ?? FirebaseMessaging.instance;

  /// Requests permissions, fetches FCM token and location, then stores them.
  Future<void> initAndSaveUserDevice(String userId) async {
    await Future.wait([
      _saveToken(userId),
      _saveLocation(userId),
    ]);
  }

  Future<void> _saveToken(String userId) async {
    // Request permission (iOS)
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

    // Listen for token refreshes
    _messaging.onTokenRefresh.listen((newToken) {
      _firestore.collection('users').doc(userId).set(
        {'fcmToken': newToken},
        SetOptions(merge: true),
      );
    });
  }

  Future<void> _saveLocation(String userId) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, // low is enough for weather
      );

      await _firestore.collection('users').doc(userId).set(
        {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      // Location is optional — don't crash the app
      print('Location fetch failed: $e');
    }
  }
}
