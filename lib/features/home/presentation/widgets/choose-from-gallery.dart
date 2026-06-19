import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/generated/l10n.dart';

class ChooseFromGalleryButton extends StatelessWidget {
  final VoidCallback onTap;

  const ChooseFromGalleryButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.h),
      child: Container(
        height: 60.h,
        padding: EdgeInsets.all(1.h), // gradient border thickness
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              ColorsManager.primaryGreen,
              ColorsManager.secondaryGreen,
            ],
          ),
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onTap,
            icon: const Icon(
              Icons.file_upload_outlined,
              color: ColorsManager.darkGreen,
            ),
            label: Text(
              S.of(context).chooseFromGallery,
              style: TextStyles.font18DarkGreen400Weight,
            ),
            style: ButtonStyle(
              // Inner background
              backgroundColor: WidgetStateProperty.all(ColorsManager.white),

              // IMPORTANT: remove default border
              side: WidgetStateProperty.all(BorderSide.none),

              // Match inner radius with outer (minus padding)
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19.h),
                ),
              ),

              // Optional: remove splash overlay color
              overlayColor: WidgetStateProperty.all(
                ColorsManager.primaryGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
