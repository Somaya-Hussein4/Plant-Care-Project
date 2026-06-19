import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/networking/api_constant.dart';
import 'package:graduation_project/core/networking/auth_api_service.dart';
import 'package:graduation_project/core/networking/dio_factory.dart';
import 'package:graduation_project/features/auth/data/repo/auth_repository.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/logic/cubit/forget_password_cubit.dart';
import 'package:graduation_project/features/history/data/api_service/history_api_service.dart';
import 'package:graduation_project/features/history/data/repo/history_repo.dart';
import 'package:graduation_project/features/history/data/source/history_remote_ds.dart';
import 'package:graduation_project/features/history/logic/cubit/history_cubit.dart';
import 'package:graduation_project/features/home/data/image_picker.dart';
import 'package:graduation_project/features/home/logic/home_cubit.dart';
import 'package:graduation_project/features/notifications/data/repo/notification_repository.dart';
import 'package:graduation_project/features/notifications/data/sources/notification_remote_data_source.dart';
import 'package:graduation_project/features/notifications/data/sources/weather_api_service.dart';
import 'package:graduation_project/features/notifications/data/sources/weather_remote_data_source.dart';
import 'package:graduation_project/features/notifications/logic/cubit/notification_cubit.dart';
import 'package:graduation_project/features/profile/data/repository/profile_repo.dart';
import 'package:graduation_project/features/profile/data/services/profile_api_service.dart';
import 'package:graduation_project/features/profile/logic/language/language_cubit.dart';
import 'package:graduation_project/features/profile/logic/profile_cubit.dart';
import 'package:graduation_project/features/result/data/repo/result_repo.dart';
import 'package:graduation_project/features/result/logic/cubit/result_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ─── Storage ──────────────────────────────────────
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // ─── Language (singleton so Dio can read it live) ─
  sl.registerLazySingleton(() => LanguageCubit());

  // ─── Dio instances ────────────────────────────────
  sl.registerLazySingleton<Dio>(
    () => DioFactory.createDio(
      sl<FlutterSecureStorage>(),
      sl<LanguageCubit>(),
    ),
    instanceName: 'authDio',
  );
  sl.registerLazySingleton<Dio>(
    () => DioFactory.createDio(
      sl<FlutterSecureStorage>(),
      sl<LanguageCubit>(),
      baseUrl: ApiConstants.plant,
    ),
    instanceName: 'plantDio',
  );
  sl.registerLazySingleton<Dio>(
    () => DioFactory.createDio(
      sl<FlutterSecureStorage>(),
      sl<LanguageCubit>(),
      baseUrl: ApiConstants.baseUrl,
    ),
    instanceName: 'profileDio',
  );

  // ─── API Services ─────────────────────────────────
  sl.registerLazySingleton(
      () => AuthApiService(sl<Dio>(instanceName: 'authDio')));
  sl.registerLazySingleton(
      () => HistoryApiService(sl<Dio>(instanceName: 'plantDio')));
  sl.registerLazySingleton(
      () => ProfileApiService(sl<Dio>(instanceName: 'profileDio')));

  // ─── Data Sources ─────────────────────────────────
  sl.registerLazySingleton(
      () => HistoryRemoteDataSource(sl<HistoryApiService>()));

  // ─── Repositories ─────────────────────────────────
  sl.registerLazySingleton(
      () => AuthRepository(sl<AuthApiService>(), sl<FlutterSecureStorage>()));
  sl.registerLazySingleton(
      () => ResultRepository(sl<Dio>(instanceName: 'plantDio')));
  sl.registerLazySingleton(
      () => HistoryRepository(sl<HistoryRemoteDataSource>()));
  sl.registerLazySingleton(
      () => ProfileRepositoryImpl(sl<ProfileApiService>()));
  sl.registerLazySingleton<NotificationRepositoryImpl>(
      () => NotificationRepositoryImpl(
            notificationDataSource: NotificationRemoteDataSourceImpl(),
            weatherDataSource:
                WeatherRemoteDataSourceImpl(WeatherApiService(Dio())),
          ));

  // ─── Cubits ───────────────────────────────────────
  sl.registerFactory(() => AuthCubit(sl<AuthRepository>()));
  sl.registerFactory(() => ForgetPasswordCubit(sl<AuthRepository>()));
  sl.registerFactory(() => ResultCubit(sl<ResultRepository>()));
  sl.registerFactory(() => HistoryCubit(
        sl<HistoryRepository>(),
        storage: sl<FlutterSecureStorage>(),
      ));
  sl.registerFactory(() => ProfileCubit(sl<ProfileRepositoryImpl>()));
  sl.registerFactory(() => HomeCubit(ImageService()));
  sl.registerFactory(() => NotificationCubit(sl<NotificationRepositoryImpl>()));
  // LanguageCubit is now a singleton above, remove from here
}
