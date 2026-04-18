import 'package:json_annotation/json_annotation.dart';

part 'cloud_image_model.g.dart';

@JsonSerializable()
class CloudImage {
  final String secure_url;

  CloudImage({required this.secure_url});

  factory CloudImage.fromJson(Map<String, dynamic> json) =>
      _$CloudImageFromJson(json);

  Map<String, dynamic> toJson() => _$CloudImageToJson(this);
}
