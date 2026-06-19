import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  static const _key = 'app_locale';

  LanguageCubit() : super(const Locale('en'));

  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'en';
    emit(Locale(code));
  }

  Future<void> changeLanguage(String languageCode) async {
    // 1. save locally
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, languageCode);
    emit(Locale(languageCode));

    // 2. save to Firestore so Cloud Functions send in the right language
    final firebaseUid = FirebaseAuth.instance.currentUser?.uid;
    if (firebaseUid != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUid)
          .set({'language': languageCode}, SetOptions(merge: true));
    }
  }
}
