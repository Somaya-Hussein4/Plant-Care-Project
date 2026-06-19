import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/app_button.dart';
import 'package:graduation_project/core/shared_widgets/app_text_form_field.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/features/auth/logic/cubit/forget_password_cubit.dart';
import 'package:graduation_project/features/auth/logic/cubit/forget_password_state.dart';
import 'package:graduation_project/generated/l10n.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;

  ResetPasswordPage({super.key, required this.email});

  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          resetPasswordSuccess: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).passwordResetSuccess)));
            context.go('/login');
          },
          error: (message) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          },
        );
      },
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppText(
                  title: (context) => S.of(context).resetPassword,
                ),
                SizedBox(height: 24.h),
                Text(
                  '${S.of(context).enterOtp} $email',
                  style: TextStyles.font14DarkGrey400Weight,
                ),
                SizedBox(height: 24.h),
                AppTextFormField(
                  controller: otpController,
                  hintText: S.of(context).hintOtp,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).hintOtp;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                AppTextFormField(
                  controller: newPasswordController,
                  hintText: S.of(context).hintPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).hintPassword;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (context, state) {
                    final isLoading = state is ResetPasswordLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: isLoading ? '' : S.of(context).resetPassword,
                        onPressed: isLoading
                            ? null
                            : () => context
                                .read<ForgetPasswordCubit>()
                                .resetPassword(
                                  email,
                                  otpController.text.trim(),
                                  newPasswordController.text.trim(),
                                ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
