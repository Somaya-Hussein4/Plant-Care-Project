import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/notifications/data/repo/notification_repository.dart';
import 'package:graduation_project/features/notifications/logic/cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;
  StreamSubscription? _subscription;

  NotificationCubit(this._repository)
      : super(const NotificationState.initial());

  void listenToNotifications(String userId) {
    emit(const NotificationState.loading());
    _subscription?.cancel();

    _subscription = _repository.getNotifications(userId).listen(
      (notifications) {
        final unread = notifications.where((n) => !n.isRead).length;

        final currentWeather =
            state.mapOrNull(loaded: (s) => s.weatherForecast);

        emit(NotificationState.loaded(
          notifications: notifications,
          unreadCount: unread,
          weatherForecast: currentWeather,
        ));
      },
      onError: (e) => emit(NotificationState.error(e.toString())),
    );
  }

  Future<void> fetchWeatherForecast() async {
    final current = state.mapOrNull(loaded: (s) => s);
    if (current == null) return;

    emit(current.copyWith(isWeatherLoading: true));

    final forecast = await _repository.getTomorrowWeatherForecast();

    final latest = state.mapOrNull(loaded: (s) => s);
    if (latest == null) return;

    emit(latest.copyWith(
      weatherForecast: forecast,
      isWeatherLoading: false,
    ));
  }

  // ─── Actions ───────────────────────────────────────────────────────────────

  Future<void> markAsRead(String userId, String notificationId) async {
    try {
      await _repository.markAsRead(userId, notificationId);
    } catch (e) {
      emit(NotificationState.error(e.toString()));
    }
  }

  Future<void> markAllAsRead(String userId) async {
    try {
      await _repository.markAllAsRead(userId);
    } catch (e) {
      emit(NotificationState.error(e.toString()));
    }
  }

  Future<void> deleteNotification(String userId, String notificationId) async {
    try {
      await _repository.deleteNotification(userId, notificationId);
    } catch (e) {
      emit(NotificationState.error(e.toString()));
    }
  }

  // ─── Cleanup ───────────────────────────────────────────────────────────────

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
