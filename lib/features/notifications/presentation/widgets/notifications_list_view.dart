import 'package:flutter/material.dart';
import 'package:graduation_project/features/notifications/data/models/notification_model.dart';
import 'package:graduation_project/features/notifications/presentation/widgets/empty_notifications_widgets.dart';
import 'package:graduation_project/features/notifications/presentation/widgets/notification_tile.dart';

class NotificationsListView extends StatelessWidget {
  final List<NotificationModel> notifications;
  final String userId;
  final void Function(String notificationId) onDismissed;

  const NotificationsListView({
    super.key,
    required this.notifications,
    required this.userId,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const EmptyNotificationsWidget();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationTile(
          notification: notification,
          onDismissed: () => onDismissed(notification.id),
        );
      },
    );
  }
}
