import 'package:graduation_project/core/networking/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/features/auth/data/models/auth_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.auth)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(ApiConstants.login)
  Future<AuthResponseModel> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.signup)
  Future<AuthResponseModel> signup(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.refresh)
  Future<AuthResponseModel> refreshToken(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.logout)
  Future<void> logout(@Body() Map<String, dynamic> body);
  //login with google
  @POST(ApiConstants.socialLogin)
  Future<AuthResponseModel> googleLogin(@Body() Map<String, dynamic> body);
}
