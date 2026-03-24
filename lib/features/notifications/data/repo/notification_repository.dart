import 'package:geolocator/geolocator.dart';
import '../models/notification_model.dart';
import '../models/weather_forecast_model.dart';
import '../sources/notification_remote_data_source.dart';
import '../sources/weather_remote_data_source.dart';

abstract class NotificationRepository {
  Stream<List<NotificationModel>> getNotifications(String userId);
  Future<WeatherForecastModel?> getTomorrowWeatherForecast();
  Future<void> markAsRead(String userId, String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<void> deleteNotification(String userId, String notificationId);
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _notificationDataSource;
  final WeatherRemoteDataSource _weatherDataSource;

  NotificationRepositoryImpl({
    required NotificationRemoteDataSource notificationDataSource,
    required WeatherRemoteDataSource weatherDataSource,
  })  : _notificationDataSource = notificationDataSource,
        _weatherDataSource = weatherDataSource;

  @override
  Stream<List<NotificationModel>> getNotifications(String userId) =>
      _notificationDataSource.getNotificationsStream(userId);

  @override
  Future<WeatherForecastModel?> getTomorrowWeatherForecast() async {
    try {
      final position = await _getCurrentPosition();
      if (position == null) return null;

      return await _weatherDataSource.getTomorrowForecast(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> markAsRead(String userId, String notificationId) =>
      _notificationDataSource.markAsRead(userId, notificationId);

  @override
  Future<void> markAllAsRead(String userId) =>
      _notificationDataSource.markAllAsRead(userId);

  @override
  Future<void> deleteNotification(String userId, String notificationId) =>
      _notificationDataSource.deleteNotification(userId, notificationId);

  // ─── Private ───────────────────────────────────────────────────────────────

  Future<Position?> _getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }
}
