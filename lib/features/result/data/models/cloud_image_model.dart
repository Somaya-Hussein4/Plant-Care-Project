import 'package:json_annotation/json_annotation.dart';

part 'cloud_image_model.g.dart';

@JsonSerializable()
class CloudImageModel {
  @JsonKey(name: 'secure_url')
  final String secureUrl;

  const CloudImageModel({required this.secureUrl});

  factory CloudImageModel.fromJson(Map<String, dynamic> json) =>
      _$CloudImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CloudImageModelToJson(this);
}
