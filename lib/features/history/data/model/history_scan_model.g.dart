// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_scan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryScanModel _$HistoryScanModelFromJson(Map<String, dynamic> json) =>
    HistoryScanModel(
      id: json['_id'] as String,
      plant: json['plant'] as String,
      healthStatus: json['healthStatus'] as String,
      disease: json['disease'] as String?,
      severity: json['severity'] as String,
      cloudImage:
          CloudImage.fromJson(json['cloudImage'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$HistoryScanModelToJson(HistoryScanModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'plant': instance.plant,
      'healthStatus': instance.healthStatus,
      'disease': instance.disease,
      'severity': instance.severity,
      'cloudImage': instance.cloudImage,
      'createdAt': instance.createdAt,
    };
