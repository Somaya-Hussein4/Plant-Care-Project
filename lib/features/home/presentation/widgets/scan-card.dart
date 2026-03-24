import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';

class ScanCard extends StatelessWidget {
  final VoidCallback onScanTap;

  const ScanCard({
    super.key,
    required this.onScanTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onScanTap,
      child: Container(
        width: 341.w,
        height: 200.h,
        padding: EdgeInsets.all(9.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ColorsManager.primaryGreen, ColorsManager.secondaryGreen],
          ),
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/bigc.png',
                  width: 100.w,
                  height: 100.h,
                ),
                Image.asset(
                  'assets/images/smallc.png',
                  width: 80.w,
                  height: 80.h,
                ),
                Image.asset(
                  'assets/images/camera.png',
                  width: 38.w,
                  height: 38.h,
                ),
              ],
            ),
            SizedBox(height: 9.h),
            Text(
              'Take a Photo',
              textAlign: TextAlign.center,
              style: TextStyles.font18White400Weight,
            ),
            SizedBox(height: 5.h),
            Text('Capture your crop for analysis',
                textAlign: TextAlign.center,
                style: TextStyles.font18White400Weight),
          ],
        ),
      ),
    );
  }
}
