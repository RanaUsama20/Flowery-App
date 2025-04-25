import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/checkout/domain/entity/request/shipping_request_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/base_state/base_state.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../cart/domain/entity/cart_data_entity.dart';
import '../../../../cart/domain/usecase/cart_usecase.dart';
import '../../../../profile/domain/entity/profile_data_entity/profile_data_entity.dart';
import '../../../../profile/domain/usecase/get_profile_data_usecase.dart';
import '../../../domain/entity/response/cash_payment/cash_payment_response_entity.dart';
import '../../../domain/entity/response/credit_card_payment/checkout_session_entity.dart';
import '../../../domain/usecase/cash_payment_use_case.dart';
import '../../../domain/usecase/credit_card_payment_use_case.dart';
import 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutStates> {
  final CashPaymentUseCase _cashPaymentUseCase;
  final CreditCardPaymentUseCase _creditCardPaymentUseCase;
  final CartUseCase _cartUseCase;

  final GetProfileDataUseCase _getProfileDataUseCase;

  CheckoutCubit(this._cashPaymentUseCase, this._creditCardPaymentUseCase,
      this._cartUseCase, this._getProfileDataUseCase)
      : super(CheckoutStates());
  void doIntent(CheckoutAction action) {
    switch (action) {
      case GetAddressAction():
        _getDeliveryAddress();
        break;
      case SetPaymentMethodAction methodAction:
        setSelectedPaymentMethod(methodAction.method);
        break;
    }
  }

  List<AddressEntity> addresses = [];
  void saveAddressList(List<AddressEntity> list) {
    addresses = list;
  }

  String? selectedAddressId;
  void selectAddress(String addressId) {
    selectedAddressId = addressId;
  }

  String _selectedMethod = "";

  void setSelectedPaymentMethod(String method) {
    _selectedMethod = method;
    emit(state.copyWith(selectedPaymentMethod: _selectedMethod));
  }

  Future<void> _getDeliveryAddress() async {
    emit(state.copyWith(profileState: BaseLoadingState()));
    final result = await _getProfileDataUseCase.call();
    switch (result) {
      case SuccessResult<ProfileDataEntity>():
        {
          emit(state.copyWith(profileState: BaseHideLoadingState()));
          emit(state.copyWith(profileState: BaseSuccessState(data: result)));
        }
      case FailureResult<ProfileDataEntity>():
        {
          emit(
            state.copyWith(
              profileState: BaseErrorState(
                  errorMessage: result.exception.toString(),
                  exception: result.exception),
            ),
          );
        }
    }
    return null;
  }

  Future<void> getCartProducts() async {
    final result = await _cartUseCase.getProductToCart();
    switch (result) {
      case SuccessResult<CartModelEntity>():
        {
          if (result.numOfCartItems == 0) {
            emit(state.copyWith(creditCardState: BaseSuccessState()));
          } else {
            emit(
              state.copyWith(
                creditCardState:
                    BaseErrorState(errorMessage: 'payment not done'),
              ),
            );
          }
        }
      case FailureResult<CartModelEntity>():
        {
          emit(
            state.copyWith(
              creditCardState: BaseErrorState(
                errorMessage: result.error.toString(),
                exception: Exception(result.error),
              ),
            ),
          );
        }
    }
  }

  Future<void> placeOrder() async {
    if (_selectedMethod.isEmpty) {
      emit(state.copyWith(
        paymentState: BaseErrorState(
          errorMessage: 'Please select a payment method',
          exception: Exception('No payment method selected'),
        ),
      ));
      return;
    }

    if (selectedAddressId == null || addresses.isEmpty) {
      emit(state.copyWith(
        paymentState: BaseErrorState(
          errorMessage: 'Please select a shipping address',
          exception: Exception('No address selected'),
        ),
      ));
      return;
    }

    final selectedAddress = addresses.firstWhere(
      (element) => element.id == selectedAddressId,
    );

    if (_selectedMethod == LocaleKeys.checkout_Cash_on_delivery.tr()) {
      await _cashPayment(selectedAddress);
    } else if (_selectedMethod == LocaleKeys.checkout_Credit_card.tr()) {
      await _creditCardPayment(selectedAddress);
    }
  }

  Future<CashPaymentResponseEntity?> _cashPayment(
      AddressEntity selectedAddress) async {
    ShippingRequestEntity requestEntity = ShippingRequestEntity(
        shippingAddress: ShippingAddressEntity(
            street: selectedAddress.street ?? '' ,
            phone: selectedAddress.phone ?? '',
            city: selectedAddress.city ?? '',
            lat: selectedAddress.lat ?? '', long: selectedAddress.long ?? '')
    );

    emit(state.copyWith(paymentState: BaseLoadingState()));

    final result = await _cashPaymentUseCase.call(requestEntity);

    switch (result) {
      case SuccessResult<CashPaymentResponseEntity?>():
        {
          emit(state.copyWith(paymentState: BaseHideLoadingState()));
          emit(state.copyWith(paymentState: BaseSuccessState(data: result)));
        }
      case FailureResult<CashPaymentResponseEntity?>():
        {
          emit(
            state.copyWith(
              paymentState: BaseErrorState(
                  errorMessage: result.exception.toString(),
                  exception: result.exception),
            ),
          );
        }
    }
    return null;
  }

  Future<CheckoutSessionEntity?> _creditCardPayment(
      AddressEntity selectedAddress) async {
    ShippingRequestEntity requestEntity = ShippingRequestEntity(
      shippingAddress: ShippingAddressEntity(
          street: selectedAddress.street ?? '' ,
          phone: selectedAddress.phone ?? '',
          city: selectedAddress.city ?? '',
          lat: selectedAddress.lat ?? '', long: selectedAddress.long ?? '')
        );

    emit(state.copyWith(paymentState: BaseLoadingState()));

    final result = await _creditCardPaymentUseCase.call(requestEntity);

    switch (result) {
      case SuccessResult<CheckoutSessionEntity?>():
        {
          emit(state.copyWith(paymentState: BaseHideLoadingState()));
          emit(state.copyWith(paymentState: BaseSuccessState(data: result)));
        }
      case FailureResult<CheckoutSessionEntity?>():
        {
          emit(
            state.copyWith(
              paymentState: BaseErrorState(
                  errorMessage: result.exception.toString(),
                  exception: result.exception),
            ),
          );
        }
    }
    return null;
  }
}
