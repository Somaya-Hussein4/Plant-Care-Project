// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponseModel _$MessageResponseModelFromJson(
        Map<String, dynamic> json) =>
    MessageResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$MessageResponseModelToJson(
        MessageResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
