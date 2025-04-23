import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/base_state/base_state.dart';

 class CheckoutStates extends Equatable {
  final BaseState? profileState;
  final BaseState? paymentState;
  final String? selectedPaymentMethod;


  const CheckoutStates({
   this.profileState,
   this.paymentState,
   this.selectedPaymentMethod

  });

  CheckoutStates copyWith({
   BaseState? profileState,
   BaseState? paymentState,
   String? selectedPaymentMethod,


  }) {
   return CheckoutStates(
    profileState: profileState ?? this.profileState,
    paymentState: paymentState ?? this.paymentState,

    selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,

   );
  }

  @override
  List<Object?> get props => [profileState,paymentState,selectedPaymentMethod];
}


sealed class CheckoutAction {}


final class GetAddressAction extends CheckoutAction {

 GetAddressAction();
}

final class SetPaymentMethodAction extends CheckoutAction {
 final String method;

 SetPaymentMethodAction(this.method);
}




