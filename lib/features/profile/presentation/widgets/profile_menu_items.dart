import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color iconColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.iconColor = ColorsManager.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          width: 390.w,
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: ColorsManager.midGrey, // 0x80DADADA
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorsManager.borderGrey),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: Icon(icon, size: 18.r, color: iconColor),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  label,
                  style: TextStyles.font18semiTransparentBlack400Weight,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: ColorsManager.darkGrey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
