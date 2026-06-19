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
import 'package:graduation_project/features/auth/presentation/widgets/already_have_account_text.dart';
import 'package:graduation_project/features/auth/presentation/widgets/login_with_google.dart';
import 'package:graduation_project/generated/l10n.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
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
                  CenteredImage(imagePath: "assets/images/signup.png"),

                  SizedBox(height: 15.h),

                  /// 🔹 Form section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).welcome,
                          style: TextStyles.font28Black600Weight,
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          S.of(context).createAccount,
                          style: TextStyles.font16Black400Weight,
                        ),

                        SizedBox(height: 15.h),

                        /// Name
                        AppTextFormField(
                          hintText: S.of(context).hintFullName,
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).nameRequired;
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 25.h),

                        /// Email
                        AppTextFormField(
                          hintText: S.of(context).hintEmail,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).emailRequired;
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 25.h),

                        /// Password
                        AppTextFormField(
                          hintText: S.of(context).hintPassword,
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).passwordRequired;
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 50.h),

                        state.maybeWhen(
                            orElse: () => AppButton(
                                  text: S.of(context).signUp,
                                  onPressed: _isFormValid
                                      ? () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          context.read<AuthCubit>().signup(
                                                nameController.text,
                                                emailController.text,
                                                passwordController.text,
                                              );
                                        }
                                      : null,
                                )),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                S.of(context).orContinueWith,
                                style: TextStyles.font14DarkGrey400Weight,
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        LoginWithGoogle(),
                        SizedBox(height: 20.h),

                        AlreadyHaveAccountText()
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
