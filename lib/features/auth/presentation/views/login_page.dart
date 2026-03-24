import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/app_button.dart';
import 'package:graduation_project/core/shared_widgets/app_main_image.dart';
import 'package:graduation_project/core/shared_widgets/app_text_form_field.dart';

import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_state.dart';
import 'package:graduation_project/features/auth/presentation/widgets/dont_have_account_text.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (user) => context.push('/home'),
            failure: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error)),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              onChanged: () {
                final isValid = _formKey.currentState?.validate() ?? false;
                if (isValid != _isFormValid) {
                  setState(() {
                    _isFormValid = isValid;
                  });
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 Top image (full width)
                  CenteredImage(imagePath: "assets/images/login.png"),

                  SizedBox(height: 24.h),

                  /// 🔹 Form section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyles.font28Black600Weight,
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          "Login to your account",
                          style: TextStyles.font16Black400Weight,
                        ),

                        SizedBox(height: 24.h),

                        /// Email
                        AppTextFormField(
                          hintText: "Email",
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 25.h),

                        /// Password
                        AppTextFormField(
                          hintText: "Password",
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.h, right: 4.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                context.push('/forgot-password');
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyles.font14DarkGrey400Weight,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 130.h),

                        /// Login button / loader
                        state.maybeWhen(
                            loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            orElse: () => AppButton(
                                  text: "Login",
                                  onPressed: _isFormValid
                                      ? () {
                                          if (!_formKey.currentState!
                                              // ignore: curly_braces_in_flow_control_structures
                                              .validate()) {
                                            return;
                                          }
                                          context.read<AuthCubit>().login(
                                                emailController.text,
                                                passwordController.text,
                                              );
                                        }
                                      : null,
                                )),
                        SizedBox(height: 24.h),
                        DontHaveAccountText()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
