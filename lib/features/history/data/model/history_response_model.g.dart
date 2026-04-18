// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryResponseModel _$HistoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    HistoryResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: HistoryDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HistoryResponseModelToJson(
        HistoryResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
