import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

import 'package:retrofit/http.dart';

part 'result_api_service.g.dart';

@RestApi()
abstract class ResultApiService {
  factory ResultApiService(Dio dio, {String baseUrl}) = _ResultApiService;
}
