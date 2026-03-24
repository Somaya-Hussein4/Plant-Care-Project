import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_constant.dart';
import 'package:graduation_project/features/notifications/data/models/weather_forecast_model.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.openMeteoBaseUrl)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio, {String baseUrl}) = _WeatherApiService;

  @GET('')
  Future<WeatherForecastModel> getTomorrowForecast({
    @Query('latitude') required double latitude,
    @Query('longitude') required double longitude,
    @Query('daily') String daily = 'weathercode,precipitation_sum',
    @Query('timezone') String timezone = 'auto',
    @Query('start_date') required String startDate,
    @Query('end_date') required String endDate,
  });
}
