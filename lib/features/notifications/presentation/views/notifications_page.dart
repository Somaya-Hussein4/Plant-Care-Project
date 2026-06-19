import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/features/notifications/presentation/widgets/notifications_list_view.dart';
import 'package:graduation_project/generated/l10n.dart';
import '../../logic/cubit/notification_cubit.dart';
import '../../logic/cubit/notification_state.dart';

class NotificationsPage extends StatefulWidget {
  final String userId;

  const NotificationsPage({super.key, required this.userId});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>()
      ..listenToNotifications(widget.userId)
      ..fetchWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppText(title: (context) => S.of(context).notifications),
          Expanded(
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.primaryGreen,
                      strokeWidth: 2.5,
                    ),
                  ),
                  error: (msg) => Center(
                    child: Text(
                      msg,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  loaded: (notifications, unreadCount, weatherForecast,
                      isWeatherLoading) {
                    return NotificationsListView(
                      notifications: notifications,
                      userId: widget.userId,
                      onDismissed: (id) => context
                          .read<NotificationCubit>()
                          .deleteNotification(widget.userId, id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
