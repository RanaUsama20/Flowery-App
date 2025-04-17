import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/cart/domain/usecase/cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../domain/entity/cart_data_entity.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final CartUseCase _cartUseCase;
  CartModelEntity? _localCart;


  CartCubit(this._cartUseCase ,) : super(CartInitialState());

  Future<CartModelEntity> addProductToCart(String productId, num quantity) async {
    try {
      final addProductToCart = await _cartUseCase.addProductToCart(productId, quantity);
        emit(CartSuccessState(addProductToCart ));
      return addProductToCart;
    } catch (e) {
      emit(CartErrorState("${LocaleKeys.Error_Bad_request.tr()}${e.toString()}"));
      return CartModelEntity();
    }
  }


  Future<CartModelEntity> getProductToCart() async {

    emit(CartLoadingState());
    try {
      final productCart = await _cartUseCase.getProductToCart();
      _localCart = productCart;

      emit(CartSuccessState(productCart));
          return productCart;
    } catch (e) {
      emit(CartErrorState("${LocaleKeys.Error_Bad_request.tr()}${e.toString()}"));
      return CartModelEntity();
    }
  }


  Future<CartModelEntity> deleteProductToCart(String cartItemId) async {

    try {
      final productCart = await _cartUseCase.deleteProductToCart(cartItemId);
      _localCart = productCart;
      emit(CartSuccessState(productCart));
      return productCart;
    } catch (e) {
      emit(CartErrorState("${LocaleKeys.Error_Bad_request.tr()}${e.toString()}"));
      return CartModelEntity();
    }
  }



  Future<CartModelEntity?> updateProductQuantity(String productId, int quantity) async {

    try {
      final response = await _cartUseCase.updateProductQuantity(productId,  quantity);
      _localCart = response;
      emit(CartSuccessState(_localCart!));
    } catch (e) {

      emit(CartErrorState("${LocaleKeys.Error_Bad_request.tr()}${e.toString()}"));
    }
    return null;
  }




}

