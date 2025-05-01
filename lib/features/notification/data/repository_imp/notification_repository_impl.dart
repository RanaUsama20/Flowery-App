import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/network/remote/api_manager.dart';
import 'package:flowery_app/features/notification/data/data_source/notification_data_source.dart';
import 'package:flowery_app/features/notification/domain/entity/all_notification_entity.dart';
import 'package:flowery_app/features/notification/domain/repositroy/notification_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final ApiManager _apiManager;
  final NotificationDataSource _notificationDataSource;
  NotificationRepositoryImpl(this._apiManager, this._notificationDataSource);
  @override
  Future<Result<List<AllNotificationEntity>?>> getAllNotifications(
      String? sort) async {
    final ans = await _apiManager.execute<List<AllNotificationEntity>?>(() {
      return _notificationDataSource.getAllNotifications(sort);
    });
    return ans;
  }
}
