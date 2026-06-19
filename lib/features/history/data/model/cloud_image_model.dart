import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cloud_image_model.g.dart';

@JsonSerializable()
class CloudImage extends Equatable {
  final String secure_url;

  const CloudImage({required this.secure_url});

  factory CloudImage.fromJson(Map<String, dynamic> json) =>
      _$CloudImageFromJson(json);

  Map<String, dynamic> toJson() => _$CloudImageToJson(this);
  @override
  List<Object?> get props => [secure_url];
}
