import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/base_state/base_state.dart';

 class CheckoutStates extends Equatable {
  final BaseState? profileState;
  final BaseState? paymentState;
  final BaseState? creditCardState;
  final String? selectedPaymentMethod;


  const CheckoutStates({
   this.profileState,
   this.paymentState,
   this.creditCardState,
   this.selectedPaymentMethod

  });

  CheckoutStates copyWith({
   BaseState? profileState,
   BaseState? paymentState,
   BaseState? creditCardState,
   String? selectedPaymentMethod,


  }) {
   return CheckoutStates(
    profileState: profileState ?? this.profileState,
    paymentState: paymentState ?? this.paymentState,
    creditCardState: creditCardState ?? this.creditCardState,

    selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,

   );
  }

  @override
  List<Object?> get props => [profileState,paymentState,selectedPaymentMethod,creditCardState];
}


sealed class CheckoutAction {}


final class GetAddressAction extends CheckoutAction {

 GetAddressAction();
}

final class SetPaymentMethodAction extends CheckoutAction {
 final String method;

 SetPaymentMethodAction(this.method);
}




