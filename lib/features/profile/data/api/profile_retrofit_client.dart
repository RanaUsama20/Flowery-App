import 'package:dio/dio.dart';
import 'package:flowery_app/core/network/remote/api_constants.dart';
import 'package:flowery_app/features/profile/data/model/response/profile_data/profile_data_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../auth/data/model/request/edit_profile_request.dart';
import '../../../auth/data/model/response/edit_profile_response.dart';
import '../model/request/change_password/change_password_request_model.dart';
import '../model/response/change_password/change_password_response_model.dart';

part 'profile_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileRetrofitClient {
  @factoryMethod
  factory ProfileRetrofitClient(Dio dio) = _ProfileRetrofitClient;

  // Future<HomeOfCategoryAndBestSellerAndOccasion>getHomedata(@Header('Authorization') String? token);

  @GET(ApiConstants.profileData)
  Future<ProfileDataDto> getProfile(@Header('Authorization') String? token);

  @PATCH(ApiConstants.changePasswordRoute)
  Future<ChangePasswordResponseDto?> changePassword(
      @Body() ChangePasswordRequestDto? changePasswordRequest,
      @Header('Authorization') String? token);

  @PUT("auth/editProfile")
  Future<EditProfileResponse> editProfile(
      @Header("Authorization") String token,
      @Body() EditProfileRequest request);
}



