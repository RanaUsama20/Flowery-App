import 'package:dio/dio.dart';
import 'package:flowery_app/core/network/remote/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../model/request/shipping_request_dto.dart';
import '../model/response/cash_payment/cash_payment_response_dto.dart';
import '../model/response/credit_card_payment/checkout_session_dto.dart';


part 'checkout_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CheckoutRetrofitClient {
  @factoryMethod
  factory CheckoutRetrofitClient(Dio dio) = _CheckoutRetrofitClient;
  @POST(ApiConstants.cashPaymentRoute)
  Future<CashPaymentResponseDto?> cashPayment(
      @Body() ShippingRequestDto? shippingRequest,
      @Header("Authorization") String? token,

  );

  @POST(ApiConstants.creditCardPaymentRoute)
  Future<CheckoutSessionDto?> creditCardPayment(
      @Body() ShippingRequestDto? shippingRequest,
      @Header("Authorization") String? token,

      );

}
