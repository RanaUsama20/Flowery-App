import 'package:dio/dio.dart';
import 'package:flowery_app/core/network/remote/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../model/request/change_password/change_password_request_model.dart';
import '../model/response/change_password/change_password_response_model.dart';

part 'profile_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileRetrofitClient {
  @factoryMethod
  factory ProfileRetrofitClient(Dio dio) = _ProfileRetrofitClient;

  @PATCH(ApiConstants.changePasswordRoute)
  Future<ChangePasswordResponseDto?> changePassword(
      @Body() ChangePasswordRequestDto? changePasswordRequest,
      @Header('Authorization') String? token);

}