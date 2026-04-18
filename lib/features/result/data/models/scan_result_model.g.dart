// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanResultModel _$ScanResultModelFromJson(Map<String, dynamic> json) =>
    ScanResultModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      plant: json['plant'] as String,
      healthStatus: json['healthStatus'] as String,
      disease: json['disease'] as String?,
      severity: json['severity'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      description: json['description'] as String,
      cloudImage:
          CloudImageModel.fromJson(json['cloudImage'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ScanResultModelToJson(ScanResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'plant': instance.plant,
      'healthStatus': instance.healthStatus,
      'disease': instance.disease,
      'severity': instance.severity,
      'confidence': instance.confidence,
      'description': instance.description,
      'cloudImage': instance.cloudImage,
      'createdAt': instance.createdAt,
    };
