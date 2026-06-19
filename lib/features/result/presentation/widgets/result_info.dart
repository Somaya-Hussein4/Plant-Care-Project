import 'package:flutter/material.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';

class ResultInfoCard extends StatelessWidget {
  final String description;
  final bool isHealthy;
  const ResultInfoCard(
      {super.key, required this.description, required this.isHealthy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.midGrey,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryGreen.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isHealthy ? Icons.check_circle : Icons.info_outline,
            color: isHealthy
                ? ColorsManager.primaryGreen
                : ColorsManager.secondaryRed,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              description,
              style: TextStyles.font16veryDarkGrey400Weight,
            ),
          ),
        ],
      ),
    );
  }
}
