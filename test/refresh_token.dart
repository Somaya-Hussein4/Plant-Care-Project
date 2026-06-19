import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_project/core/networking/api_constant.dart';
import 'package:graduation_project/core/networking/dio_factory.dart';
import 'package:graduation_project/features/profile/logic/language/language_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class FakeLanguageCubit extends Mock implements LanguageCubit {
  @override
  Locale get state => const Locale('en');
}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late FakeLanguageCubit fakeLanguageCubit;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    fakeLanguageCubit = FakeLanguageCubit();
  });

  test('تحديث الـ Token وإعادة الطلب بنجاح عند استقبال 401', () async {
    final dio = DioFactory.createDio(mockStorage, fakeLanguageCubit);
    
    // 🟢 CRITICAL FIX: We must use the same mock adapter for BOTH dio instances
    final dioAdapter = HttpClientAdapterMock();
    DioFactory.refreshDioAdapter = dioAdapter;
    dio.httpClientAdapter = dioAdapter;
    
    
    // This hooks into your private static _refreshDio instance inside your factory
    // to prevent it from trying to make a real network connection to 10.0.2.2
    final refreshDioField = Uri.parse(ApiConstants.baseUrl).host.isNotEmpty; 
    // We target your project's internal `DioFactory._refreshDio` instance
    // (We use a clever trick here: you can access static fields directly)
    // Note: If Dart complains about privacy, see option below. For now we override via reference:
    // If your project setup allows modifying it, we explicitly mock both.
    
    // Let's ensure the adapter intercepts ALL requests from the factory:
    // Since _refreshDio is a static final inside DioFactory, we assign our mock adapter to it:
    // (Make sure to temporarily remove 'private' modifier from _refreshDio if needed, or use reflection/setter. 
    // Alternatively, a cleaner approach is shown below by directly setting it via an accessible property if available,
    // but we can simply force it since it is defined in your class)
    
    // Stubbing Storage Reads
    when(() => mockStorage.read(key: "accessToken")).thenAnswer((_) async => "old_access_token");
    when(() => mockStorage.read(key: "refreshToken")).thenAnswer((_) async => "valid_refresh_token");
    
    // Stubbing Storage Writes
    when(() => mockStorage.write(key: "accessToken", value: "new_access_token")).thenAnswer((_) async => null);
    when(() => mockStorage.write(key: "refreshToken", value: "new_refresh_token")).thenAnswer((_) async => null);

    // 🟢 FIX 2: Stubbing Storage Deletes to avoid the Future<void> Null type error
    when(() => mockStorage.delete(key: "accessToken")).thenAnswer((_) async => null);
    when(() => mockStorage.delete(key: "refreshToken")).thenAnswer((_) async => null);

    int requestCount = 0;

    dioAdapter.onRequests = (options) {
      // Catching the refresh endpoint
      if (options.path.contains(ApiConstants.refresh) || options.path.contains('refresh-token')) {
        return ResponseBody.fromString(
          '{"data": {"credinti": {"accessToken": "new_access_token", "refreshToken": "new_refresh_token"}}}',
          200,
          headers: {Headers.contentTypeHeader: [Headers.jsonContentType]},
        );
      }

      requestCount++;
      if (requestCount == 1) {
        return ResponseBody.fromString('{"message": "Unauthorized"}', 401,
          headers: {Headers.contentTypeHeader: [Headers.jsonContentType]},
        );
      } else {
        return ResponseBody.fromString('{"status": "success", "data": "some_data"}', 200,
          headers: {Headers.contentTypeHeader: [Headers.jsonContentType]},
        );
      }
    };

    // To make sure your static _refreshDio also uses this mock adapter, 
    // we can temporarily expose it or set it up if your class allows.
    // If your _refreshDio is private (starts with an underscore), add a temporary helper method 
    // inside your production `DioFactory` class like this: 
    // `static set refreshAdapter(HttpClientAdapter a) => _refreshDio.httpClientAdapter = a;`
    // Then call: DioFactory.refreshAdapter = dioAdapter;
    
    // For now, let's assume you added that setter, or you can make _refreshDio non-private:
    // DioFactory.refreshDio.httpClientAdapter = dioAdapter; 

    final response = await dio.get('/test-endpoint');

    expect(response.statusCode, 200);
    expect(requestCount, 2);

    verify(() => mockStorage.write(key: "accessToken", value: "new_access_token")).called(1);
    verify(() => mockStorage.write(key: "refreshToken", value: "new_refresh_token")).called(1);
  });
}

class HttpClientAdapterMock implements HttpClientAdapter {
  late ResponseBody Function(RequestOptions options) onRequests;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return onRequests(options);
  }

  @override
  void close({bool force = false}) {}
}