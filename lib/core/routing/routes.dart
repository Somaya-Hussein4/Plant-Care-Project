import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/injection_contaner.dart';
import 'package:graduation_project/core/shared_widgets/main_scaffold.dart';
import 'package:graduation_project/features/about_us/presentation/views/about_us_page.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/logic/cubit/forget_password_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/forget_password_page.dart';
import 'package:graduation_project/features/auth/presentation/views/login_page.dart';
import 'package:graduation_project/features/auth/presentation/views/reset_password_page.dart';
import 'package:graduation_project/features/auth/presentation/views/signup_page.dart';
import 'package:graduation_project/features/care_guide/presentation/page/care_guide_page.dart';
import 'package:graduation_project/features/history/logic/cubit/history_cubit.dart';
import 'package:graduation_project/features/history/presentation/views/history_page.dart';
import 'package:graduation_project/features/home/logic/home_cubit.dart';
import 'package:graduation_project/features/home/presentation/views/home_page.dart';
import 'package:graduation_project/features/notifications/logic/cubit/notification_cubit.dart';
import 'package:graduation_project/features/notifications/presentation/views/notifications_page.dart';
import 'package:graduation_project/features/profile/logic/profile_cubit.dart';
import 'package:graduation_project/features/profile/presentation/views/profile_page.dart';
import 'package:graduation_project/features/result/logic/cubit/result_cubit.dart';
import 'package:graduation_project/features/result/presentation/views/result_page.dart';
import 'package:graduation_project/features/splash_screen/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/SplashScreen',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: SignupPage(),
      ),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<ForgetPasswordCubit>(),
        child: ForgetPasswordPage(),
      ),
    ),
    GoRoute(
      path: '/reset-password',
      name: 'reset-password',
      builder: (context, state) {
        final email = state.extra as String;
        return BlocProvider(
          create: (_) => sl<ForgetPasswordCubit>(),
          child: ResetPasswordPage(email: email),
        );
      },
    ),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => BlocProvider(
            create: (_) => sl<HomeCubit>(),
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: '/notifications',
          name: 'notifications',
          builder: (context, state) {
            final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
            return BlocProvider(
              create: (_) => sl<NotificationCubit>(),
              child: NotificationsPage(userId: userId),
            );
          },
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<AuthCubit>()),
              BlocProvider(create: (_) => sl<ProfileCubit>()..loadProfile()),
            ],
            child: const ProfilePage(),
          ),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutUsPage(),
        ),
        GoRoute(
          path: '/result',
          name: 'result',
          builder: (context, state) {
            final imagePath = state.extra as String;
            return BlocProvider(
              create: (_) => sl<ResultCubit>()..scan(imagePath),
              child: const ResultPage(),
            );
          },
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => BlocProvider(
            create: (_) => sl<HistoryCubit>()..fetchHistory(),
            child: const HistoryPage(),
          ),
        ),
        GoRoute(
          path: '/guide',
          builder: (context, state) => const CareGuidePage(),
        ),
      ],
    ),
  ],
);
