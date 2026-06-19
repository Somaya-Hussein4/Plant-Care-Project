import 'package:flutter/material.dart';
import 'package:graduation_project/core/theming/colors.dart';

class SeverityBadge extends StatelessWidget {
  final String severity;
  const SeverityBadge({super.key, required this.severity});

  Color _getColor() {
    final s = severity.toLowerCase().trim();
    if (s == 'high' || s == 'مرتفع') return ColorsManager.secondaryRed;
    if (s == 'medium' || s == 'متوسط') return ColorsManager.orange;
    if (s == 'low' || s == 'منخفض') return ColorsManager.primaryGreen;
    return ColorsManager.darkGrey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        severity[0].toUpperCase() + severity.substring(1),
        style: const TextStyle(
          color: ColorsManager.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}
