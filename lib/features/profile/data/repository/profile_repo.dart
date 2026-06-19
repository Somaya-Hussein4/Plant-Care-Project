import 'dart:io';
import 'package:dio/dio.dart';
import '../models/profile_image_model.dart';
import '../services/profile_api_service.dart';

abstract class ProfileRepository {
  Future<ProfileUserModel> getProfileImage();
  Future<ProfileUserModel> uploadProfileImage(File imageFile);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _apiService;

  ProfileRepositoryImpl(this._apiService);

  @override
  Future<ProfileUserModel> getProfileImage() async {
    try {

      final response = await _apiService.getProfileImage();
      return response.data.user;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? e.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileUserModel> uploadProfileImage(File imageFile) async {
    try {
      final response = await _apiService.uploadProfileImage(imageFile);
      return response.data.user;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? e.message);
    }
  }
}
