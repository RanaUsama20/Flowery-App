import 'package:dio/dio.dart';
import 'package:flowery_app/core/network/remote/api_constants.dart';
import 'package:flowery_app/features/profile/data/model/response/profile_data/profile_data_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'profile_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileRetrofitClient {
  @factoryMethod
  factory ProfileRetrofitClient(Dio dio) = _ProfileRetrofitClient;

  // Future<HomeOfCategoryAndBestSellerAndOccasion>getHomedata(@Header('Authorization') String? token);

  @GET(ApiConstants.profileData)
  Future<ProfileDataDto> getProfile(@Header('Authorization') String? token);
}
