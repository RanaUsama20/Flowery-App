
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../entity/request/shipping_request_entity.dart';
import '../entity/response/credit_card_payment/checkout_session_entity.dart';
import '../repository/checkout_repository.dart';


@injectable
class CreditCardPaymentUseCase {
  final CheckoutRepository _checkoutRepository;
  CreditCardPaymentUseCase(this._checkoutRepository);
  // Future<Result<CheckoutSessionEntity?>> call(ShippingRequestEntity? shippingRequest) async {
  //   final result = await _checkoutRepository.creditCardPayment(shippingRequest);
  //
  //   return result;
  //
  // }
  Future<Result<CheckoutSessionEntity?>> call() async {
    final result = await _checkoutRepository.creditCardPayment();

    return result;

  }

  }