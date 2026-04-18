import 'package:json_annotation/json_annotation.dart';
import 'history_data_model.dart';

part 'history_response_model.g.dart';

@JsonSerializable()
class HistoryResponseModel {
  final bool success;
  final String message;
  final HistoryDataModel data;

  HistoryResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponseModelToJson(this);
}
