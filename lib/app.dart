import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/di/injection_contaner.dart';
import 'package:graduation_project/core/routing/routes.dart';
import 'package:graduation_project/core/services/push_notification_service.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/features/profile/logic/language/language_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    PushNotificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LanguageCubit>(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
            designSize: const Size(412, 917),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp.router(
              locale: locale,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: ColorsManager.background,
              ),
            ),
          );
        },
      ),
    );
  }
}
