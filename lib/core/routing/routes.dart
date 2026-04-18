import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/networking/api_constant.dart';
import 'package:graduation_project/core/networking/auth_api_service.dart';
import 'package:graduation_project/core/networking/dio_factory.dart';
import 'package:graduation_project/core/shared_widgets/main_scaffold.dart';
import 'package:graduation_project/features/about_us/presentation/views/about_us_page.dart';
import 'package:graduation_project/features/auth/data/repo/auth_repository.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/login_page.dart';
import 'package:graduation_project/features/auth/presentation/views/signup_page.dart';
import 'package:graduation_project/features/history/data/api_service/history_api_service.dart';
import 'package:graduation_project/features/history/data/repo/history_repo.dart';
import 'package:graduation_project/features/history/data/source/history_remote_ds.dart';
import 'package:graduation_project/features/history/logic/cubit/history_cubit.dart';
import 'package:graduation_project/features/history/presentation/views/history_page.dart';
import 'package:graduation_project/features/home/data/image_picker.dart';
import 'package:graduation_project/features/home/logic/home_cubit.dart';
import 'package:graduation_project/features/home/presentation/views/home_page.dart';
import 'package:graduation_project/features/notifications/data/repo/notification_repository.dart';
import 'package:graduation_project/features/notifications/data/sources/notification_remote_data_source.dart';
import 'package:graduation_project/features/notifications/data/sources/weather_api_service.dart';
import 'package:graduation_project/features/notifications/data/sources/weather_remote_data_source.dart';
import 'package:graduation_project/features/notifications/logic/cubit/notification_cubit.dart';
import 'package:graduation_project/features/notifications/presentation/views/notifications_page.dart';
import 'package:graduation_project/features/profile/presentation/views/profile_page.dart';
import 'package:graduation_project/features/result/data/repo/result_repo.dart';
import 'package:graduation_project/features/result/logic/cubit/result_cubit.dart';
import 'package:graduation_project/features/result/presentation/views/result_page.dart';
import 'package:graduation_project/features/splash_screen/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
        path: '/SplashScreen',
        name: 'splash',
        builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) {
        final storage = FlutterSecureStorage();
        final dio = DioFactory.createDio(storage);
        final apiService = AuthApiService(dio);
        final authRepository = AuthRepository(apiService, storage);
        return BlocProvider(
          create: (_) => AuthCubit(authRepository),
          child: LoginPage(),
        );
      },
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) {
        final storage = FlutterSecureStorage();
        final dio = DioFactory.createDio(storage);
        final apiService = AuthApiService(dio);
        final authRepository = AuthRepository(apiService, storage);
        return BlocProvider(
          create: (_) => AuthCubit(authRepository),
          child: SignupPage(),
        );
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => BlocProvider(
            create: (context) =>
                HomeCubit(ImageService()), // Inject the service here
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: '/notifications',
          name: 'notifications',
          builder: (context, state) {
            // gets the anonymous Firebase UID
            final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

            final weatherDio = Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

            final notificationDataSource = NotificationRemoteDataSourceImpl();
            final weatherApiService = WeatherApiService(weatherDio);
            final weatherDataSource =
                WeatherRemoteDataSourceImpl(weatherApiService);
            final repository = NotificationRepositoryImpl(
              notificationDataSource: notificationDataSource,
              weatherDataSource: weatherDataSource,
            );

            return BlocProvider(
              create: (_) => NotificationCubit(repository),
              child: NotificationsPage(userId: userId),
            );
          },
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) {
            final storage = FlutterSecureStorage();
            final dio = DioFactory.createDio(storage);
            final apiService = AuthApiService(dio);
            final authRepository = AuthRepository(apiService, storage);
            return BlocProvider(
              create: (_) => AuthCubit(authRepository),
              child: ProfilePage(),
            );
          },
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
            final storage = const FlutterSecureStorage();
            final dio = DioFactory.createDio(storage);
            final repository = ResultRepository(dio);

            return BlocProvider(
              create: (_) => ResultCubit(repository)..scan(imagePath),
              child: const ResultPage(),
            );
          },
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) {
            final storage = const FlutterSecureStorage();
            final dio = Dio(BaseOptions(baseUrl: ApiConstants.plant));
            final apiService = HistoryApiService(dio);
            final remote = HistoryRemoteDataSource(apiService);
            final repo = HistoryRepository(remote);

            return BlocProvider(
              create: (_) =>
                  HistoryCubit(repo, storage: storage)..fetchHistory(),
              child: const HistoryPage(),
            );
          },
        ),
        /* 
        
        GoRoute(
          path: '/guide',
          builder: (context, state) => const CareGuidePage(),
        ),
        GoRoute(
          path: '/scan',
          builder: (context, state) => const ScanPage(),
        ),
        
       */
      ],
    ),
  ],
);
