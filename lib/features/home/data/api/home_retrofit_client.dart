import 'package:dio/dio.dart';
import 'package:flowery_app/features/home/data/models/response/occasion_tab_response_dto.dart';
import 'package:flowery_app/features/home/data/models/response/prodect_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/remote/api_constants.dart';

part 'home_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeRetrofitClient {
  @factoryMethod
  factory HomeRetrofitClient(Dio dio) = _HomeRetrofitClient;

  @GET(ApiConstants.occasions)
  Future<OccasionsTabResponseDto> getTabOccasions();

  @GET(ApiConstants.getProductsById)
  Future<ProductResponseDto> getProductsByOccasion(@Query("occasion") String occasionId);
}
