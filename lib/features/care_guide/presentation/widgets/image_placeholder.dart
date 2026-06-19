import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/colors.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder(
      {super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorsManager.lightGreen,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: const Icon(Icons.image_not_supported_outlined,
          color: ColorsManager.grey),
    );
  }
}
