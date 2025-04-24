import 'package:dio/dio.dart';
import 'package:flowery_app/core/network/remote/api_constants.dart';
import 'package:flowery_app/features/home/data/model/response/occasions/prodect_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'search_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class SearchRetrofitClient {
  @factoryMethod
  factory SearchRetrofitClient(Dio dio) = _SearchRetrofitClient;

  @GET(ApiConstants.getProductsById)
  Future<ProductResponseDto> searchProduct(@Query("keyword") String query);
}
