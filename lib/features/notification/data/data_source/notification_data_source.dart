import 'package:flowery_app/features/notification/domain/entity/all_notification_entity.dart';

abstract class NotificationDataSource {
  Future<List<AllNotificationEntity>?> getAllNotifications(String? sort);
}