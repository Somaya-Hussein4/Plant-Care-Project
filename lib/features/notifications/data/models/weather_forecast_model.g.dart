// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecastModel _$WeatherForecastModelFromJson(
        Map<String, dynamic> json) =>
    WeatherForecastModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      daily: DailyForecast.fromJson(json['daily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherForecastModelToJson(
        WeatherForecastModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'daily': instance.daily,
    };

DailyForecast _$DailyForecastFromJson(Map<String, dynamic> json) =>
    DailyForecast(
      weathercode: (json['weathercode'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      precipitationSum: (json['precipitation_sum'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$DailyForecastToJson(DailyForecast instance) =>
    <String, dynamic>{
      'weathercode': instance.weathercode,
      'precipitation_sum': instance.precipitationSum,
    };
