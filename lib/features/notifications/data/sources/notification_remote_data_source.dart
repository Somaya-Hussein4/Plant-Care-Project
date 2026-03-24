import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Stream<List<NotificationModel>> getNotificationsStream(String userId);
  Future<void> markAsRead(String userId, String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<void> deleteNotification(String userId, String notificationId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseFirestore _firestore;

  NotificationRemoteDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _notificationsRef(String userId) =>
      _firestore.collection('users').doc(userId).collection('notifications');

  @override
  Stream<List<NotificationModel>> getNotificationsStream(String userId) {
    return _notificationsRef(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              // Firestore Timestamp → DateTime
              final ts = data['createdAt'];
              data['createdAt'] = ts is Timestamp
                  ? ts.toDate().toIso8601String()
                  : DateTime.now().toIso8601String();
              data['id'] = doc.id;
              return NotificationModel.fromJson(data);
            }).toList());
  }

  @override
  Future<void> markAsRead(String userId, String notificationId) async {
    await _notificationsRef(userId)
        .doc(notificationId)
        .update({'isRead': true});
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    final batch = _firestore.batch();
    final unread =
        await _notificationsRef(userId).where('isRead', isEqualTo: false).get();
    for (final doc in unread.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  @override
  Future<void> deleteNotification(String userId, String notificationId) async {
    await _notificationsRef(userId).doc(notificationId).delete();
  }
}
