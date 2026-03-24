import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/routing/routes.dart';
import 'package:graduation_project/core/services/push_notification_service.dart';

import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/features/auth/presentation/views/login_page.dart';

import 'package:graduation_project/features/splash_screen/splash_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    // Foreground notifications + Android channel setup
    PushNotificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorsManager.background,
        ),
      ),
    );
  }
}
