import 'package:flutter/material.dart';
import 'package:graduation_project/core/theming/style.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        top: true,
        bottom: false,
        child: Text(
          'Plant Disease Detection',
          style: TextStyles.font24Gradient400Weight,
        ),
      ),
    );
  }
}
