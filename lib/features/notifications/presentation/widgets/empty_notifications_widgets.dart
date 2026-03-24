import 'package:flutter/material.dart';
import 'package:graduation_project/core/theming/style.dart';

class EmptyNotificationsWidget extends StatelessWidget {
  const EmptyNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🌱', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: TextStyles.font19veryDarkGreen400Weight,
          ),
          const SizedBox(height: 8),
          Text(
            "We'll remind you when your plants\nneed attention.",
            textAlign: TextAlign.center,
            style: TextStyles.font19veryDarkGreen400Weight,
          ),
        ],
      ),
    );
  }
}
