import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_state.freezed.dart';

@freezed
class ForgetPasswordState with _$ForgetPasswordState {
  const factory ForgetPasswordState.initial() = Initial;
  const factory ForgetPasswordState.sendOtpLoading() = SendOtpLoading;
  const factory ForgetPasswordState.sendOtpSuccess(String message) =
      SendOtpSuccess;
  const factory ForgetPasswordState.resetPasswordLoading() =
      ResetPasswordLoading;
  const factory ForgetPasswordState.resetPasswordSuccess(String message) =
      ResetPasswordSuccess;
  const factory ForgetPasswordState.error(String message) = Error;
}
