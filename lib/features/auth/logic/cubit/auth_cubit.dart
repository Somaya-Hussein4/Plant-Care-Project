import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/user_device_service.dart';
import 'package:graduation_project/features/auth/data/repo/auth_repository.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  final UserDeviceService _deviceService;

  AuthCubit(this.repository)
      : _deviceService = UserDeviceService(),
        super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    try {
      final response = await repository.login(email, password);

      final user = response.data.user;
      if (user == null) {
        emit(const AuthState.failure('User data not found'));
        return;
      }

      await FirebaseAuth.instance.signInAnonymously();
      final firebaseUid = FirebaseAuth.instance.currentUser?.uid ?? '';
      await _deviceService.initAndSaveUserDevice(firebaseUid);

      emit(AuthState.success(user));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> signup(String name, String email, String password) async {
    emit(const AuthState.loading());
    try {
      final response = await repository.signup(email, password);

      final user = response.data.user;
      if (user == null) {
        emit(const AuthState.failure('User data not found'));
        return;
      }

      await FirebaseAuth.instance.signInAnonymously();
      final firebaseUid = FirebaseAuth.instance.currentUser?.uid ?? '';
      await _deviceService.initAndSaveUserDevice(firebaseUid);

      emit(AuthState.success(user));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> refreshToken() async {
    try {
      await repository.refreshToken();
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthState.loading());
      await repository.logout();
      emit(AuthState.loggedOut());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }
}
