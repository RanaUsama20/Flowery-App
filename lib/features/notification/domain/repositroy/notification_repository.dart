import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/notification/domain/entity/all_notification_entity.dart';

abstract class NotificationRepository {
  Future<Result<List<AllNotificationEntity>?>>getAllNotifications(String? sort);
}