
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecase/best_seller_use_case.dart';
import 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutStates> {
  final CheckoutUseCase _checkoutUseCase;

CheckoutCubit(this._checkoutUseCase) : super(CheckoutStates());
}
