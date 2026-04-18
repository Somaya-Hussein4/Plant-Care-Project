import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/core/networking/auth_api_service.dart';
import 'package:graduation_project/features/auth/data/models/auth_response_model.dart';
import 'package:graduation_project/features/auth/data/models/token_model.dart';

class AuthRepository {
  final AuthApiService api;
  final FlutterSecureStorage storage;

  AuthRepository(this.api, this.storage);

  Future<AuthResponseModel> login(String email, String password) async {
    final response = await api.login({'email': email, 'password': password});
    await _saveTokens(response.data.tokens, response.data.user!.id);
    return response;
  }

  Future<AuthResponseModel> signup(String email, String password) async {
    final response = await api.signup({
      'email': email,
      'password': password,
    });
    await _saveTokens(response.data.tokens, response.data.user!.id);
    return response;
  }

  Future<AuthResponseModel> refreshToken() async {
    final refreshToken = await storage.read(key: 'refreshToken');
    final existingUserId = await storage.read(key: 'userId') ?? '';
    final response = await api.refreshToken({'refreshToken': refreshToken});
    await _saveTokens(response.data.tokens, existingUserId);
    return response;
  }

  Future<void> logout() async {
    try {
      final refreshToken = await storage.read(key: 'refreshToken');
      await api.logout({'refreshToken': refreshToken});
    } finally {
      await _clearTokens();
    }
  }

  Future<AuthResponseModel> googleLogin(String idToken) async {
    final response = await api.googleLogin({
      'idToken': idToken,
      'provider': 'google',
    });
    await _saveTokens(response.data.tokens, response.data.user!.id);
    return response;
  }

  Future<void> _saveTokens(TokenModel tokens, String userId) async {
    await storage.write(key: 'accessToken', value: tokens.accessToken);
    await storage.write(key: 'refreshToken', value: tokens.refreshToken);
    await storage.write(key: 'userId', value: userId);
  }

  Future<void> _clearTokens() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    await storage.delete(key: 'userId');
  }
}
