// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloudProfileImage _$CloudProfileImageFromJson(Map<String, dynamic> json) =>
    CloudProfileImage(
      publicId: json['public_id'] as String,
      secureUrl: json['secure_url'] as String,
    );

Map<String, dynamic> _$CloudProfileImageToJson(CloudProfileImage instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'secure_url': instance.secureUrl,
    };

ProfileUserModel _$ProfileUserModelFromJson(Map<String, dynamic> json) =>
    ProfileUserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      cloudProfileImage: json['CloudProfileImage'] == null
          ? null
          : CloudProfileImage.fromJson(
              json['CloudProfileImage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileUserModelToJson(ProfileUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'CloudProfileImage': instance.cloudProfileImage,
    };

ProfileImageResponse _$ProfileImageResponseFromJson(
        Map<String, dynamic> json) =>
    ProfileImageResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ProfileImageData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileImageResponseToJson(
        ProfileImageResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ProfileImageData _$ProfileImageDataFromJson(Map<String, dynamic> json) =>
    ProfileImageData(
      user: ProfileUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileImageDataToJson(ProfileImageData instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
