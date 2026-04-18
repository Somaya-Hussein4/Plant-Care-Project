import 'package:json_annotation/json_annotation.dart';
import 'history_scan_model.dart';

part 'history_data_model.g.dart';

@JsonSerializable()
class HistoryDataModel {
  final List<HistoryScanModel> scans;

  HistoryDataModel({required this.scans});

  factory HistoryDataModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryDataModelToJson(this);
}
