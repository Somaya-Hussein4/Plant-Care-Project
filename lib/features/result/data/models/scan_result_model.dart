import 'package:graduation_project/features/result/data/models/cloud_image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scan_result_model.g.dart';

@JsonSerializable()
class ScanResultModel {
  final String id;
  final String userId;
  final String plant;
  final String healthStatus;
  final String? disease;
  final String severity;
  final double confidence;
  final String description;
  final CloudImageModel cloudImage;
  final String createdAt;

  const ScanResultModel({
    required this.id,
    required this.userId,
    required this.plant,
    required this.healthStatus,
    this.disease,
    required this.severity,
    required this.confidence,
    required this.description,
    required this.cloudImage,
    required this.createdAt,
  });

  factory ScanResultModel.fromJson(Map<String, dynamic> json) =>
      _$ScanResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScanResultModelToJson(this);
}
