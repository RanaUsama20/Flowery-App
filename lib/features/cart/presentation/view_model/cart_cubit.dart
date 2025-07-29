import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/cart/domain/usecase/cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failuer.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../domain/entity/cart_data_entity.dart';
import '../../../../core/enum/state_user.dart';
import '../../../../core/app/app_cubit/app_cubit_cubit.dart';
import '../../../../core/di/service_locator.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final CartUseCase _cartUseCase;
  CartModelEntity? _localCart;
  CartCubit(this._cartUseCase) : super(CartInitialState());

  final AppCubit _appCubit = serviceLocator<AppCubit>();

  bool get _isGuest => _appCubit.getStateUser == StateUser.guest;

  Future<void> addProductToCart(String productId, num quantity) async {
    if (_isGuest) {
      emit(CartErrorState(
          ServerFailure(LocaleKeys.Error_YouHaveToLoginToUseThisFeature.tr())));
      return;
    }

    try {
      final result = await _cartUseCase.addProductToCart(productId, quantity);
      if (result is SuccessResult<CartModelEntity>) {
        _localCart = result.data;
        emit(CartSuccessState(result.data));
      } else if (result is FailureResult<CartModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CartErrorState(failure));
      }
    } catch (e) {
      emit(CartErrorState(ServerFailure(e.toString())));
    }
  }

  Future<void> getProductToCart() async {
    if (_isGuest) {
      emit(CartErrorState(
          ServerFailure(LocaleKeys.Error_YouHaveToLoginToUseThisFeature.tr())));
      return;
    }

    emit(CartLoadingState());
    try {
      final result = await _cartUseCase.getProductToCart();
      if (result is SuccessResult<CartModelEntity>) {
        _localCart = result.data;
        emit(CartSuccessState(result.data));
      } else if (result is FailureResult<CartModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CartErrorState(failure));
      }
    } catch (e) {
      emit(CartErrorState(ServerFailure(e.toString())));
    }
  }

  Future<void> deleteProductToCart(String cartItemId) async {
    if (_isGuest) {
      emit(CartErrorState(
          ServerFailure(LocaleKeys.Error_YouHaveToLoginToUseThisFeature.tr())));
      return;
    }

    try {
      final result = await _cartUseCase.deleteProductToCart(cartItemId);
      if (result is SuccessResult<CartModelEntity>) {
        _localCart = result.data;
        emit(CartSuccessState(result.data));
      } else if (result is FailureResult<CartModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CartErrorState(failure));
      }
    } catch (e) {
      emit(CartErrorState(ServerFailure(e.toString())));
    }
  }

  Future<void> updateProductQuantity(String productId, int quantity) async {
    if (_isGuest) {
      emit(CartErrorState(
          ServerFailure(LocaleKeys.Error_YouHaveToLoginToUseThisFeature.tr())));
      return;
    }

    try {
      final result = await _cartUseCase.updateProductQuantity(productId, quantity);
      if (result is SuccessResult<CartModelEntity>) {
        _localCart = result.data;
        emit(CartSuccessState(result.data));
      } else if (result is FailureResult<CartModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CartErrorState(failure));
      }
    } catch (e) {
      emit(CartErrorState(ServerFailure(e.toString())));
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
