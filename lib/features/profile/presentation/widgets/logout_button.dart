import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/generated/l10n.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;

  const LogoutButton({
    super.key,
    this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // let Container handle the color

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 390.w,
          height: 50.h,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: ColorsManager.midGrey, // 0x80DADADA
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorsManager.borderGrey), // 0xFFC4C4C4
          ),
          child: Row(
            children: [
              // Red icon box
              SizedBox(
                width: 36,
                height: 36,
                child: const Icon(
                  Icons.logout,
                  size: 18,
                  color: ColorsManager.grey,
                ),
              ),
              const SizedBox(width: 14),
              // Label
              Expanded(
                child: Text(
                  S.of(context).logout,
                  style: TextStyles.font18semiTransparentBlack400Weight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
