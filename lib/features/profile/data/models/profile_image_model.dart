import 'package:json_annotation/json_annotation.dart';

part 'profile_image_model.g.dart';

@JsonSerializable()
class CloudProfileImage {
  @JsonKey(name: 'public_id')
  final String publicId;

  @JsonKey(name: 'secure_url')
  final String secureUrl;

  const CloudProfileImage({
    required this.publicId,
    required this.secureUrl,
  });

  factory CloudProfileImage.fromJson(Map<String, dynamic> json) =>
      _$CloudProfileImageFromJson(json);

  Map<String, dynamic> toJson() => _$CloudProfileImageToJson(this);
}

@JsonSerializable()
class ProfileUserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  @JsonKey(name: 'CloudProfileImage')
  final CloudProfileImage? cloudProfileImage;

  const ProfileUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.cloudProfileImage,
  });

  String get fullName => '$firstName $lastName';

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUserModelToJson(this);
}

@JsonSerializable()
class ProfileImageResponse {
  final bool success;
  final String message;
  final ProfileImageData data;

  const ProfileImageResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfileImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileImageResponseToJson(this);
}

@JsonSerializable()
class ProfileImageData {
  final ProfileUserModel user;

  const ProfileImageData({required this.user});

  factory ProfileImageData.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileImageDataToJson(this);
}
