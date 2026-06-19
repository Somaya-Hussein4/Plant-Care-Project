import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graduation_project/app.dart';
import 'package:graduation_project/core/di/injection_contaner.dart';
import 'package:graduation_project/core/services/push_notification_service.dart';
import 'package:graduation_project/features/profile/logic/language/language_cubit.dart';
import 'package:graduation_project/firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await init();

  await sl<LanguageCubit>().loadSavedLocale();

  runApp(const App());
}
