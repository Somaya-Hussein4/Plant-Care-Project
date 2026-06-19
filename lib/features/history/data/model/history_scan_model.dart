import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/history/data/model/cloud_image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_scan_model.g.dart';

@JsonSerializable()
class HistoryScanModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;

  final String plant;
  final String healthStatus;
  final String? disease;
  final String severity;

  @JsonKey(name: 'cloudImage')
  final CloudImage cloudImage;

  final String createdAt;

  const HistoryScanModel({
    required this.id,
    required this.plant,
    required this.healthStatus,
    this.disease,
    required this.severity,
    required this.cloudImage,
    required this.createdAt,
  });

  factory HistoryScanModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryScanModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryScanModelToJson(this);
  @override
  List<Object?> get props => [
        id,
        plant,
        healthStatus,
        disease,
        severity,
        cloudImage,
        createdAt,
      ];
}
