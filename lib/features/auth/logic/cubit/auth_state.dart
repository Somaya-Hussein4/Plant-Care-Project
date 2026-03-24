import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_project/features/auth/data/models/user_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.success(UserModel user) = AuthSuccess;
  const factory AuthState.loggedOut() = LoggedOut;
  const factory AuthState.failure(String error) = AuthFailure;
}
