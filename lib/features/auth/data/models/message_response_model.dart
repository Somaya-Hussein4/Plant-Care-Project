import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'message_response_model.g.dart';

@JsonSerializable()
class MessageResponseModel {
  final bool success;
  final String message;

  MessageResponseModel({
    required this.success,
    required this.message,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MessageResponseModelToJson(json as MessageResponseModel);
}
