import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/features/notifications/data/models/notification_model.dart';
import 'package:graduation_project/generated/l10n.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onDismissed;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: ColorsManager.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          S.of(context).remove,
          style: TextStyle(
            color: ColorsManager.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Container(
          height: 70.h,
          width: double.infinity,
          padding: EdgeInsets.all(1.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsManager.primaryGreen.withOpacity(0.1),
                ColorsManager.secondaryGreen.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Text(
                _icon(),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  notification.body,
                  style: TextStyles.font14DarkGreen400Weight,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.more_vert,
                size: 18,
                color: ColorsManager.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _icon() {
    if (notification.notificationType == NotificationType.weather) {
      return '🌧️';
    }
    // Pick emoji based on title content
    final title = notification.title.toLowerCase();
    if (title.contains('water') || title.contains('hydrat')) return '💧';
    if (title.contains('sun') || title.contains('light')) return '☀️';
    if (title.contains('leaf') || title.contains('disease')) return '🍃';
    if (title.contains('bloom') || title.contains('flower')) return '🌺';
    if (title.contains('check')) return '🌿';
    return '🪴';
  }
}
