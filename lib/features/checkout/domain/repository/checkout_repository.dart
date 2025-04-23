
import '../../../../core/network/common/api_result.dart';
import '../entity/request/shipping_request_entity.dart';
import '../entity/response/cash_payment/cash_payment_response_entity.dart';
import '../entity/response/credit_card_payment/checkout_session_entity.dart';

abstract class CheckoutRepository{

  // Future<Result<CashPaymentResponseEntity?>> cashPayment(ShippingRequestEntity? shippingRequest);
  // Future<Result<CheckoutSessionEntity?>> creditCardPayment(ShippingRequestEntity? shippingRequest);
  Future<Result<CashPaymentResponseEntity?>> cashPayment();
  Future<Result<CheckoutSessionEntity?>> creditCardPayment();


}