import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/auth/data/repo/auth_repository.dart';
import 'package:graduation_project/features/auth/logic/cubit/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository authRepository;

  ForgetPasswordCubit(this.authRepository)
      : super(const ForgetPasswordState.initial());

  Future<void> sendOtp(String email) async {
    emit(const ForgetPasswordState.sendOtpLoading());
    try {
      final result = await authRepository.sendOtp({'email': email});

      emit(ForgetPasswordState.sendOtpSuccess(result.message));
    } catch (e) {
      emit(ForgetPasswordState.error(e.toString()));
    }
  }

  Future<void> resetPassword(
      String email, String otp, String newPassword) async {
    emit(const ForgetPasswordState.resetPasswordLoading());
    try {
      final result = await authRepository.resetPassword({
        'email': email,
        'otp': otp,
        'password': newPassword,
      });
      emit(ForgetPasswordState.resetPasswordSuccess(result.message));
    } catch (e) {
      emit(ForgetPasswordState.error(e.toString()));
    }
  }
}
