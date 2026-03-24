import 'package:json_annotation/json_annotation.dart';

part 'weather_forecast_model.g.dart';

@JsonSerializable()
class WeatherForecastModel {
  final double latitude;
  final double longitude;
  final DailyForecast daily;

  const WeatherForecastModel({
    required this.latitude,
    required this.longitude,
    required this.daily,
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastModelToJson(this);

  // Convenience getters for the first (and only) day we request
  int get weatherCode => daily.weathercode.first;
  double get precipitationSum => daily.precipitationSum.first;

  // ─── WMO code helpers ────────────────────────────────────────────────────

  static const _rainCodes = {
    51, 53, 55, // Drizzle
    61, 63, 65, // Rain
    66, 67, // Freezing rain
    71, 73, 75, 77, // Snow
    80, 81, 82, // Rain showers
    85, 86, // Snow showers
    95, 96, 99, // Thunderstorm
  };

  bool get willRain =>
      _rainCodes.contains(weatherCode) || precipitationSum >= 1;
  bool get isSnow => {71, 73, 75, 77, 85, 86}.contains(weatherCode);
  bool get isStorm => {95, 96, 99}.contains(weatherCode);
}

@JsonSerializable()
class DailyForecast {
  final List<int> weathercode;

  @JsonKey(name: 'precipitation_sum')
  final List<double> precipitationSum;

  const DailyForecast({
    required this.weathercode,
    required this.precipitationSum,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastFromJson(json);

  Map<String, dynamic> toJson() => _$DailyForecastToJson(this);
}
