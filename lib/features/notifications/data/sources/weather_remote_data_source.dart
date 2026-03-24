import 'package:graduation_project/features/notifications/data/models/weather_forecast_model.dart';
import 'weather_api_service.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherForecastModel> getTomorrowForecast({
    required double latitude,
    required double longitude,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherApiService _apiService;

  WeatherRemoteDataSourceImpl(this._apiService);

  @override
  Future<WeatherForecastModel> getTomorrowForecast({
    required double latitude,
    required double longitude,
  }) async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowStr = _formatDate(tomorrow);

    return _apiService.getTomorrowForecast(
      latitude: latitude,
      longitude: longitude,
      startDate: tomorrowStr,
      endDate: tomorrowStr,
    );
  }

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
