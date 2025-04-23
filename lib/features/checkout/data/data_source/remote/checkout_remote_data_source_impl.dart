import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/checkout/data/api/checkout_retrofit_client.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/remote/api_manager.dart';
import '../../../../../core/utils/save_local.dart';
import '../../model/request/shipping_request_dto.dart';
import '../../model/response/cash_payment/cash_payment_response_dto.dart';
import '../../model/response/credit_card_payment/checkout_session_dto.dart';
import 'checkout_remote_data_source.dart';

@Injectable(as: CheckoutRemoteDataSource)
class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final CheckoutRetrofitClient _checkoutRetrofitClient;
  final ApiManager _apiManager;

  CheckoutRemoteDataSourceImpl(this._checkoutRetrofitClient, this._apiManager);
  @override
  Future<Result<CashPaymentResponseDto?>> cashPayment() async {
    final token = await SaveLocal.getString("token");
    final fullToken = "Bearer $token";

    final response = await _apiManager.execute<CashPaymentResponseDto?>(
          () async {
        return await _checkoutRetrofitClient.cashPayment(fullToken);
      },
    );

    return response;
  }
  @override
  Future<Result<CheckoutSessionDto?>> creditCardPayment() async {
    final token = await SaveLocal.getString("token");
    final fullToken = "Bearer $token";

    final response = await _apiManager.execute<CheckoutSessionDto?>(
          () async {
        return await _checkoutRetrofitClient.creditCardPayment(fullToken);
      },
    );

    return response;
  }
  // @override
  // Future<Result<CashPaymentResponseDto?>> cashPayment(ShippingRequestDto? shippingRequest) async {
  //   final token = await SaveLocal.getString("token");
  //   final fullToken = "Bearer $token";
  //
  //   final response = await _apiManager.execute<CashPaymentResponseDto?>(
  //         () async {
  //       return await _checkoutRetrofitClient.cashPayment(shippingRequest, fullToken);
  //     },
  //   );
  //
  //   return response;
  // }
  // @override
  // Future<Result<CheckoutSessionDto?>> creditCardPayment(ShippingRequestDto? shippingRequest) async {
  //   final token = await SaveLocal.getString("token");
  //   final fullToken = "Bearer $token";
  //
  //   final response = await _apiManager.execute<CheckoutSessionDto?>(
  //         () async {
  //       return await _checkoutRetrofitClient.creditCardPayment(shippingRequest, fullToken);
  //     },
  //   );
  //
  //   return response;
  // }




}
