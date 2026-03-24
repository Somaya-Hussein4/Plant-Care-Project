import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/notification_model.dart';
import '../../data/models/weather_forecast_model.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;

  const factory NotificationState.loading() = _Loading;

  const factory NotificationState.loaded({
    required List<NotificationModel> notifications,
    @Default(0) int unreadCount,
    // null = not fetched yet, stays null if permission denied or API failed
    WeatherForecastModel? weatherForecast,
    @Default(false) bool isWeatherLoading,
  }) = _Loaded;

  const factory NotificationState.error(String message) = _Error;
}
