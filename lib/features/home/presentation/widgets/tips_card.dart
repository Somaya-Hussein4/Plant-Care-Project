import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/generated/l10n.dart';

class TipsCard extends StatelessWidget {
  const TipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(25.h),
        child: Container(
          padding: EdgeInsets.all(2.h), // border thickness
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6EEA6A),
                Color(0xFF2ECC71),
              ],
            ),
            borderRadius: BorderRadius.circular(12.h),
          ),
          child: Container(
            width: 341.w,
            height: 170.h,
            padding: EdgeInsets.all(16.h),
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(10.h),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/tips.png',
                        width: 40.w, height: 40.h),
                    Text(
                      S.of(context).scanningTips,
                      style: TextStyles.font18DarkGreen400Weight,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).tip1,
                      style: TextStyles.font16DarkGrey400Weight,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      S.of(context).tip2,
                      style: TextStyles.font16DarkGrey400Weight,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      S.of(context).tip3,
                      style: TextStyles.font16DarkGrey400Weight,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
