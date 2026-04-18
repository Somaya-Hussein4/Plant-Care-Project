import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_constant.dart';

import 'package:retrofit/retrofit.dart';

import 'package:retrofit/http.dart';

part 'result_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.plant)
abstract class ResultApiService {
  factory ResultApiService(Dio dio, {String baseUrl}) = _ResultApiService;
}
