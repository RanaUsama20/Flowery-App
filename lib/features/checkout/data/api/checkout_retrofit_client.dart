import 'package:dio/dio.dart';
import 'package:flowery_app/core/network/remote/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';


part 'checkout_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CheckoutRetrofitClient {
  @factoryMethod
  factory CheckoutRetrofitClient(Dio dio) = _CheckoutRetrofitClient;


}
