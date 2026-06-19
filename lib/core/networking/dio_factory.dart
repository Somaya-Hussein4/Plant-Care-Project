import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/core/networking/api_constant.dart';
import 'package:graduation_project/features/profile/logic/language/language_cubit.dart';

class DioFactory {
  static Completer<bool>? _refreshCompleter;

  // Always points at the auth base URL, regardless of which Dio (auth/plant/etc.)
  // triggered the 401. This is the fix — refresh must never be relative to the
  // failing request's own base URL.
  static final Dio _refreshDio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl + ApiConstants.auth,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ),
  );

  static Dio createDio(
    FlutterSecureStorage storage,
    LanguageCubit languageCubit, {
    String? baseUrl,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: "accessToken");
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          if (languageCubit.state.languageCode == 'ar') {
            options.queryParameters['lang'] = 'ar';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException e, handler) async {
          print(
              '🔴 [DIO ERROR] path=${e.requestOptions.baseUrl}${e.requestOptions.path} status=${e.response?.statusCode}');

          if (e.response?.statusCode != 401) {
            return handler.next(e);
          }

          print('🟡 [401] starting refresh flow');

          if (_refreshCompleter != null) {
            print('🟡 [401] refresh already in progress, waiting...');
            final success = await _refreshCompleter!.future;
            print('🟡 [401] waited refresh result: $success');
            if (success) {
              final newToken = await storage.read(key: "accessToken");
              e.requestOptions.headers["Authorization"] = "Bearer $newToken";
              try {
                final retry = await dio.fetch(e.requestOptions);
                return handler.resolve(retry);
              } catch (_) {
                return handler.next(e);
              }
            }
            return handler.next(e);
          }

          final refreshToken = await storage.read(key: "refreshToken");
          print(
              '🟡 [401] stored refreshToken present: ${refreshToken != null}');
          if (refreshToken == null) {
            return handler.next(e);
          }

          _refreshCompleter = Completer<bool>();

          try {
            print(
                '🟡 [401] POST ${_refreshDio.options.baseUrl}${ApiConstants.refresh}');
            final refreshResponse = await _refreshDio.post(
              ApiConstants.refresh,
              data: {"refreshToken": refreshToken},
              options: Options(
                headers: {"Authorization": "Bearer $refreshToken"},
              ),
            );
            print(
                '🟢 [REFRESH OK] status=${refreshResponse.statusCode} data=${refreshResponse.data}');

            final newAccessToken =
                refreshResponse.data["data"]["credentials"]["accessToken"];
            final newRefreshToken =
                refreshResponse.data["data"]["credentials"]["refreshToken"];

            await storage.write(key: "accessToken", value: newAccessToken);
            await storage.write(key: "refreshToken", value: newRefreshToken);

            _refreshCompleter!.complete(true);
            _refreshCompleter = null;

            e.requestOptions.headers["Authorization"] =
                "Bearer $newAccessToken";
            final clonedRequest = await dio.fetch(e.requestOptions);
            print('🟢 [RETRY OK] original request succeeded after refresh');
            return handler.resolve(clonedRequest);
          } catch (refreshError) {
            print('🔴 [REFRESH FAILED] $refreshError');
            if (refreshError is DioException) {
              print(
                  '🔴 [REFRESH FAILED] status=${refreshError.response?.statusCode} data=${refreshError.response?.data}');
            }
            await storage.delete(key: "accessToken");
            await storage.delete(key: "refreshToken");
            _refreshCompleter!.complete(false);
            _refreshCompleter = null;
            return handler.next(e);
          }
        },
      ),
    );

    return dio;
  }

  static set refreshDioAdapter(HttpClientAdapter adapter) {
    _refreshDio.httpClientAdapter = adapter;
  }
}
