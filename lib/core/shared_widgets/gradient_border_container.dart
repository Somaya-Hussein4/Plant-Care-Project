import 'package:flutter/widgets.dart';
import 'package:graduation_project/core/theming/colors.dart';

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  

  const GradientBorderContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            ColorsManager.primaryColor,
            ColorsManager.secondaryGreen,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}