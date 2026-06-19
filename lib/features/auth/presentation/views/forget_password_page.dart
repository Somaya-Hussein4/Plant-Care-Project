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

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          sendOtpSuccess: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).checkEmail)));
            context.push('/reset-password', extra: emailController.text);
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
                  title: (context) => S.of(context).forgetPassword,
                ),
                SizedBox(height: 24.h),
                Text(
                  S.of(context).sendOtp,
                  style: TextStyles.font14DarkGrey400Weight,
                ),
                SizedBox(height: 24.h),
                AppTextFormField(
                  controller: emailController,
                  hintText: S.of(context).hintEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).hintEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (context, state) {
                    final isLoading = state is SendOtpLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: isLoading ? '' : S.of(context).sendOtpButton,
                        onPressed: isLoading
                            ? null
                            : () => context
                                .read<ForgetPasswordCubit>()
                                .sendOtp(emailController.text.trim()),
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
