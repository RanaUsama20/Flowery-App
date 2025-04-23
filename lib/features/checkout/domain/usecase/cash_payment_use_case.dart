
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../entity/request/shipping_request_entity.dart';
import '../entity/response/cash_payment/cash_payment_response_entity.dart';
import '../repository/checkout_repository.dart';


@injectable
class CashPaymentUseCase {
  final CheckoutRepository _checkoutRepository;
  CashPaymentUseCase(this._checkoutRepository);
  // Future<Result<CashPaymentResponseEntity?>> call(ShippingRequestEntity? shippingRequest) async {
  //   final result = await _checkoutRepository.cashPayment(shippingRequest);
  //
  //   return result;
  //
  // }
  Future<Result<CashPaymentResponseEntity?>> call() async {
    final result = await _checkoutRepository.cashPayment();

    return result;

  }

  }