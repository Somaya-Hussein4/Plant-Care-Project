import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/auth/presentation/views/login_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SizedBox(
        height: 250.h,
        child: Center(
          child: LottieBuilder.asset(
            'assets/lottie/animated_splash_screen.json',
            width: 250.w,
          ),
        ),
      ),
      nextScreen: LoginPage(),
      splashIconSize: 300.w,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color(0xFFF9FAF7),
    );
  }
}
