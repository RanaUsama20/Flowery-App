import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/cart/domain/usecase/cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failuer.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../domain/entity/cart_data_entity.dart';

part 'cart_state.dart';
@injectable
class CartCubit extends Cubit<CartState> {
  final CartUseCase _cartUseCase;
  CartModelEntity? _localCart;

  CartCubit(this._cartUseCase) : super(CartInitialState());

  Future<void> addProductToCart(String productId, num quantity) async {
    try {
      final result = await _cartUseCase.addProductToCart(productId, quantity);
      if (result is SuccessResult<CartModelEntity>) {
        _localCart = result.data;
        emit(CartSuccessState(result.data));
      } else if (result is FailureResult<CartModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CartErrorState(ServerFailure(failure.message)));
      }
    } catch (e) {
      emit(CartErrorState(e.toString() as Failure));
    }
  }

  Future<void> getProductToCart() async {
    emit(CartLoadingState());
    try {
      final result = await _cartUseCase.getProductToCart();
      if (result is SuccessResult<CartModelEntity>) {
        _localCart = result.data;
        emit(CartSuccessState(result.data));
      } else if (result is FailureResult<CartModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CartErrorState(failure.message as Failure));
      }
    } catch (e) {
      emit(CartErrorState(e.toString() as Failure ));
    }
  }

  Future<void> deleteProductToCart(String cartItemId) async {
    try {
      final result = await _cartUseCase.deleteProductToCart(cartItemId);
      if (result is SuccessResult<CartModelEntity>) {
        _localCart = result.data;
        emit(CartSuccessState(result.data));
      } else if (result is FailureResult<CartModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CartErrorState(failure.message as Failure));
      }
    } catch (e) {
      emit(CartErrorState(e.toString() as Failure));
    }
  }

  Future<void> updateProductQuantity(String productId, int quantity) async {
    try {
      final result = await _cartUseCase.updateProductQuantity(productId, quantity);
      if (result is SuccessResult<CartModelEntity>) {
        _localCart = result.data;
        emit(CartSuccessState(result.data));
      } else if (result is FailureResult<CartModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CartErrorState(failure.message as Failure));
      }
    } catch (e) {
      emit(CartErrorState(e.toString() as Failure));
    }
  }

  Failure _extractFailure(Object exception) {
    if (exception is Failure) {
      return exception;
    } else {
      return ServerFailure(exception.toString());
    }
  }
}
