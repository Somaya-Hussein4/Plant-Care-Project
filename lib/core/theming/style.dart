import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/colors.dart';

class TextStyles {
  static TextStyle font28Black600Weight = TextStyle(
      fontSize: 28.sp, fontWeight: FontWeight.w600, color: Colors.black);
  static TextStyle font16Black400Weight = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.black);
  static TextStyle font16DarkGrey400Weight = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.darkGrey);
  static TextStyle font14DarkGrey400Weight = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.darkGrey);
  static TextStyle font17DarkGrey400Weight = TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.darkGrey);
  static TextStyle font11DarkGrey400Weight = TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.darkGrey);
  static TextStyle font18midGreen400Weight = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.midGreen);
  static TextStyle font18White400Weight = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w400, color: ColorsManager.white);
  static TextStyle font14Olive400Weight = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: ColorsManager.olive);
  static TextStyle font14Black400Weight = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: ColorsManager.black);
  static TextStyle font19veryDarkGreen400Weight = TextStyle(
      fontSize: 19.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.veryDarkGreen);
  static TextStyle font18DarkGreen400Weight = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.darkGreen);
  static TextStyle font18darkGrey400Weight = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.darkGrey);
  static TextStyle font18semiTransparentBlack400Weight = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.semiTransparentBlack);
  static TextStyle font22darkGreen400Weight = TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.darkGreen);
  static TextStyle font29darkGreen900weight = TextStyle(
      fontSize: 29.sp,
      fontWeight: FontWeight.w900,
      color: ColorsManager.darkGreen);
  static TextStyle font20Black900weight = TextStyle(
      fontSize: 20.sp, fontWeight: FontWeight.w900, color: ColorsManager.black);

  static TextStyle font24Gradient400Weight = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
      foreground: Paint()
        ..shader = LinearGradient(
          colors: [ColorsManager.secondaryGreen, ColorsManager.primaryGreen],
        ).createShader(const Rect.fromLTWH(0, 0, 200, 70)));
}
