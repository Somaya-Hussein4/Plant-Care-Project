import 'package:dio/dio.dart';
import 'package:graduation_project/features/history/data/model/history_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'history_api_service.g.dart';

@RestApi()
abstract class HistoryApiService {
  factory HistoryApiService(Dio dio, {String baseUrl}) = _HistoryApiService;

  @GET('/history/{userId}')
  Future<HistoryResponseModel> getHistory(
    @Path('userId') String userId,
    @Query('page') int page,
    @Query('limit') int limit,
  );
}
