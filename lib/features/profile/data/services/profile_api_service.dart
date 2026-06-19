import 'dart:io';
import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_constant.dart';
import 'package:graduation_project/features/profile/data/models/profile_image_model.dart';

class ProfileApiService {
  final Dio _dio;

  ProfileApiService(this._dio);

  Future<ProfileImageResponse> getProfileImage() async {
    final response = await _dio.get(ApiConstants.profile);
    return ProfileImageResponse.fromJson(response.data);
  }

// PATCH — upload new profile image
  Future<ProfileImageResponse> uploadProfileImage(File imageFile) async {
    final formData = FormData.fromMap({
      'profileImage': await MultipartFile.fromFile(
        // ✅ key must match backend: .single("profileImage")
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    final response = await _dio.patch(
      // ✅ PATCH not PUT
      ApiConstants.profile,
      data: formData,
    );
    return ProfileImageResponse.fromJson(response.data);
  }
}
