import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/notification/domain/entity/all_notification_entity.dart';
import 'package:flowery_app/features/notification/domain/repositroy/notification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllNotificationUseCase {
  final NotificationRepository _notificationRepository;
  GetAllNotificationUseCase(this._notificationRepository);
  Future<Result<List<AllNotificationEntity>?>> call(String? sort) =>
      _notificationRepository.getAllNotifications(sort);
}
