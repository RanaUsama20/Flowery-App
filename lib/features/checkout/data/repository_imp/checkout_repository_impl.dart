import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/checkout/domain/entity/request/shipping_request_entity.dart';
import 'package:flowery_app/features/checkout/domain/entity/response/cash_payment/cash_payment_response_entity.dart';
import 'package:flowery_app/features/checkout/domain/entity/response/credit_card_payment/checkout_session_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository/checkout_repository.dart';
import '../data_source/remote/checkout_remote_data_source.dart';
import '../model/response/cash_payment/cash_payment_response_dto.dart';
import '../model/response/credit_card_payment/checkout_session_dto.dart';


@Injectable(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource _checkoutRemoteDataSource;
  CheckoutRepositoryImpl(this._checkoutRemoteDataSource);

  // @override
  // Future<Result<CashPaymentResponseEntity?>> cashPayment() async {
  //   final result = await _checkoutRemoteDataSource.cashPayment();
  //
  //   if (result is SuccessResult<CashPaymentResponseDto?>) {
  //     return SuccessResult(result.data?.toDomain());
  //   }
  //   else if (result is FailureResult<CashPaymentResponseDto?>) {
  //     return FailureResult(result.exception);
  //   }
  //   return FailureResult(Exception("Unknown error occurred"));
  // }
  //
  //
  // @override
  // Future<Result<CheckoutSessionEntity?>> creditCardPayment()async {
  //   final result = await _checkoutRemoteDataSource.creditCardPayment();
  //
  //   if (result is SuccessResult<CheckoutSessionDto?>) {
  //     return SuccessResult(result.data?.toDomain());
  //   }
  //   else if (result is FailureResult<CheckoutSessionDto?>) {
  //     return FailureResult(result.exception);
  //   }
  //   return FailureResult(Exception("Unknown error occurred"));
  // }
  //
  @override
  Future<Result<CashPaymentResponseEntity?>> cashPayment(ShippingRequestEntity? shippingRequest) async {
    final result = await _checkoutRemoteDataSource.cashPayment(shippingRequest!.toDto());

    if (result is SuccessResult<CashPaymentResponseDto?>) {
      return SuccessResult(result.data?.toDomain());
    }
    else if (result is FailureResult<CashPaymentResponseDto?>) {
      return FailureResult(result.exception);
    }
    return FailureResult(Exception("Unknown error occurred"));
  }


  @override
  Future<Result<CheckoutSessionEntity?>> creditCardPayment(ShippingRequestEntity? shippingRequest)async {
    final result = await _checkoutRemoteDataSource.creditCardPayment(shippingRequest!.toDto());

    if (result is SuccessResult<CheckoutSessionDto?>) {
      return SuccessResult(result.data?.toDomain());
    }
    else if (result is FailureResult<CheckoutSessionDto?>) {
      return FailureResult(result.exception);
    }
    return FailureResult(Exception("Unknown error occurred"));
  }
  }









