import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/base_state/base_state.dart';

 class CheckoutStates extends Equatable {
  final BaseState? baseState;


  const CheckoutStates({
   this.baseState,

  });

  CheckoutStates copyWith({
   BaseState? baseState,

  }) {
   return CheckoutStates(
    baseState: baseState ?? this.baseState,

   );
  }

  @override
  List<Object?> get props => [baseState];
}


