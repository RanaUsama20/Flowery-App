
part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {
  String? loadingMessage;
  CartLoadingState([this.loadingMessage]);
}

class CartSuccessState extends CartState {
  final CartModelEntity productCart;
  CartSuccessState(this.productCart);
}

class CartErrorState extends CartState {
  final String message;

  CartErrorState(this.message);
}



