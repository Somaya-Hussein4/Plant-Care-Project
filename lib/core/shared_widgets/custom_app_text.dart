import 'package:flutter/material.dart';
import 'package:graduation_project/core/theming/style.dart';

class CustomAppText extends StatelessWidget {
  final String title;

  const CustomAppText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        top: true,
        bottom: false,
        child: Text(
          title,
          style: TextStyles.font24Gradient400Weight,
        ),
      ),
    );
  }
}
