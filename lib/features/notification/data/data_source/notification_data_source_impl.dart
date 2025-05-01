import 'package:flowery_app/core/utils/save_local.dart';
import 'package:flowery_app/features/notification/data/api/notification_retrofit_client.dart';
import 'package:flowery_app/features/notification/data/data_source/notification_data_source.dart';
import 'package:flowery_app/features/notification/domain/entity/all_notification_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationDataSource)
class NotificationDataSourceImpl implements NotificationDataSource{
final  NotificationRetrofitClient _notificationRetrofitClient;
 NotificationDataSourceImpl(this._notificationRetrofitClient);

  @override
  Future<List<AllNotificationEntity>?> getAllNotifications(String? sort)async {
        final userToken=await SaveLocal.getString("token");
        final fullToken='Bearer $userToken';
     final ans=await  _notificationRetrofitClient.getAllNotifications(sort, fullToken);
     return ans.notifications?.map((e){return e.toAllNotificationEntity();}).toList();
    
  }
}