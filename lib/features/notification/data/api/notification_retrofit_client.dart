import 'package:dio/dio.dart';
import 'package:flowery_app/core/network/remote/api_constants.dart';
import 'package:flowery_app/features/notification/data/model/response/all_notification_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';

import 'package:retrofit/http.dart';
part 'notification_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class NotificationRetrofitClient {
  @factoryMethod
  factory NotificationRetrofitClient(Dio dio) = _NotificationRetrofitClient;

  @GET(ApiConstants.allNotifications)
  Future<AllNotificationResponseModel> getAllNotifications(
      @Query('sort') String? createdAt, @Header('Authorization') String? token);
}
