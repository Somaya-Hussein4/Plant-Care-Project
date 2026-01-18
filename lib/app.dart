import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/di/app_dependencies.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/features/auth/presentation/views/signup_page.dart';
import 'package:graduation_project/features/splash_screen/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorsManager.background,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
