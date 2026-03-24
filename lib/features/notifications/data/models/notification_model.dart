import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

enum NotificationType { proactive, weather }

@JsonSerializable()
class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;

  // weather-specific (nullable)
  final int? weatherCode;
  final double? precipitationSum;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    this.weatherCode,
    this.precipitationSum,
  });

  NotificationType get notificationType =>
      type == 'weather' ? NotificationType.weather : NotificationType.proactive;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
        id: id,
        type: type,
        title: title,
        body: body,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt,
        weatherCode: weatherCode,
        precipitationSum: precipitationSum,
      );
}
