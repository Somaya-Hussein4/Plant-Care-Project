import 'package:flutter/material.dart';
import 'package:graduation_project/features/notifications/data/models/notification_model.dart';

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
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'Remove',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFD6F5D6),
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
                style: const TextStyle(
                  fontSize: 13.5,
                  color: Color(0xFF1B4B1E),
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.more_vert,
              size: 18,
              color: Colors.green.shade700,
            ),
          ],
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
