import 'package:dio/dio.dart';
import 'package:flowery_app/core/network/remote/api_constants.dart';
import 'package:flowery_app/features/home/data/model/response/best_seller_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'home_retrofit_client.g.dart';


@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeRetrofitClient {
  @factoryMethod
  factory HomeRetrofitClient(Dio dio) = _HomeRetrofitClient;

  @GET(ApiConstants.bestSellerRoute)
  Future<BestSellerResponseDto> getBestSeller();



}