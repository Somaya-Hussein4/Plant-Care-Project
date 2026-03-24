import 'package:flutter/material.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final String hintText;
  final TextStyle? hintStyle;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Color? backgroundColor;
  final Widget? suffixIcon;

  const AppTextFormField(
      {super.key,
      this.contentPadding,
      this.controller,
      required this.hintText,
      this.hintStyle,
      this.focusedBorder,
      this.enabledBorder,
      this.inputTextStyle,
      this.obscureText,
      required this.validator,
      this.backgroundColor,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText ?? false,
      style: inputTextStyle ?? TextStyles.font16Black400Weight,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor ?? ColorsManager.white,
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyles.font16DarkGrey400Weight,
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.0),
              borderSide: BorderSide(
                color: ColorsManager.primaryGreen,
              ),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.0),
              borderSide: BorderSide(
                color: ColorsManager.lightGrey,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17.0),
          borderSide: BorderSide(
            color: ColorsManager.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17.0),
          borderSide: BorderSide(
            color: ColorsManager.red,
          ),
        ),
      ),
    );
  }
}
/* 
Input can be null (field not initialized yet)

Output must be:

null → valid

String → error message*/
