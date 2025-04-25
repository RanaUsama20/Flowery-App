

import 'package:flowery_app/features/checkout/data/model/request/shipping_request_dto.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../model/response/cash_payment/cash_payment_response_dto.dart';
import '../../model/response/credit_card_payment/checkout_session_dto.dart';

abstract class CheckoutRemoteDataSource {
  Future<Result<CashPaymentResponseDto?>> cashPayment(ShippingRequestDto? shippingRequest);
  Future<Result<CheckoutSessionDto?>> creditCardPayment(ShippingRequestDto? shippingRequest);
  // Future<Result<CashPaymentResponseDto?>> cashPayment();
  // Future<Result<CheckoutSessionDto?>> creditCardPayment();

}