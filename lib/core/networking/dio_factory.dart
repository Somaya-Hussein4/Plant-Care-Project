import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioFactory {
  static Dio createDio(FlutterSecureStorage storage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "http://localhost:3000/api/v1",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: "accessToken");
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final refreshToken = await storage.read(key: "refreshToken");

            if (refreshToken != null) {
              try {
                final refreshResponse = await dio.post(
                  "/refresh-token",
                  data: {"refreshToken": refreshToken},
                );

                final newAccessToken =
                    refreshResponse.data["data"]["tokens"]["accessToken"];
                final newRefreshToken =
                    refreshResponse.data["data"]["tokens"]["refreshToken"];

                await storage.write(key: "accessToken", value: newAccessToken);
                await storage.write(
                    key: "refreshToken", value: newRefreshToken);

                e.requestOptions.headers["Authorization"] =
                    "Bearer $newAccessToken";
                final clonedRequest = await dio.fetch(e.requestOptions);
                return handler.resolve(clonedRequest);
              } catch (refreshError) {
                await storage.delete(key: "accessToken");
                await storage.delete(key: "refreshToken");
                return handler.next(e);
              }
            }
          }

          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
