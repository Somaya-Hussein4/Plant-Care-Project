import 'package:flutter/material.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/generated/l10n.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        top: true,
        bottom: false,
        child: Text(
          S.of(context).pageTitle,
          style: TextStyles.font24Gradient400Weight,
        ),
      ),
    );
  }
}
