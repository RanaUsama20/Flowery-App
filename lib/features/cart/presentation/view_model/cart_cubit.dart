import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/enum/status.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';
import 'package:flowery_app/features/cart/domain/usecase/add_product_to_cart_use_case.dart';
import 'package:flowery_app/features/cart/domain/usecase/delete_product_to_cart_use_case.dart';
import 'package:flowery_app/features/cart/domain/usecase/get_product_cart_use_case.dart';
import 'package:flowery_app/features/cart/domain/usecase/update_product_quantity_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  CartCubit(
    this._addProduct,
    this._deleteProduct,
    this._getProduct,
    this._updateProduct,
  ) : super(const CartState());
  final AddProductToCartUseCase _addProduct;
  final DeleteProductToCartUseCase _deleteProduct;
  final GetProductCartUseCase _getProduct;
  final UpdateProductQuantityUseCase _updateProduct;
  // testing this function getting products
  Future<void> getProductToCart() async {
    emit(state.copyWith(getProductStatus: Status.loading));
    final result = await _getProduct.call();
    switch (result) {
      case SuccessResult<CartModelEntity>():
        emit(state.copyWith(
          getProductStatus: Status.success,
          cartModelEntity: result.data,
        ));
      case FailureResult<CartModelEntity>():
        emit(state.copyWith(
          getProductStatus: Status.failure,
          errorFromGetProduct: "Something went wrong while getting products",
        ));
    }
  }

  // testing this function updating quantity
  Future<void> updateProductQuantity(String cartItemId, int quantity) async {
    emit(state.copyWith(
      updateProductStatus: Status.loading,
      updatingProductIds: {...state.updatingProductIds, cartItemId},
    ));
    final result = await _updateProduct.call(cartItemId, quantity);
    switch (result) {
      case SuccessResult<CartModelEntity>():
        final updatedSet = Set<String>.from(state.updatingProductIds)..remove(cartItemId);
        emit(state.copyWith(
          updateProductStatus: Status.success,
          updatingProductIds: updatedSet,
          cartModelEntity: result.data,
        ));
      case FailureResult<CartModelEntity>():
        emit(state.copyWith(
          updateProductStatus: Status.failure,
          errorFromGetProduct: "Something went wrong while updating quantity",
        ));
    }
  }

  Future<void> deleteProduct(String cartItemId) async {
    emit(state.copyWith(
      deleteProductStatus: Status.loading,
    ));
    final result = await _deleteProduct.call(cartItemId);
    switch (result) {
      case SuccessResult<CartModelEntity>():
        emit(state.copyWith(
          deleteProductStatus: Status.success,
          cartModelEntity: result.data,
        ));
      case FailureResult<CartModelEntity>():
        emit(state.copyWith(
          deleteProductStatus: Status.failure,
          errorFromGetProduct: "Something went wrong while deleting product",
        ));
    }
  }

  Future<void> mangeAddToCart(String cartItemId) async {
    emit(state.copyWith(
      mangeAddToCartStatus: Status.loading,
      loadingProductIds: {...state.loadingProductIds, cartItemId},
    ));
    if (checkProductInCart(cartItemId)) {
      await deleteProduct(cartItemId);
    } else {
      await _addToCart(cartItemId);
    }
    final updatedSet = Set<String>.from(state.loadingProductIds)..remove(cartItemId);
    emit(state.copyWith(
      mangeAddToCartStatus: Status.success,
      loadingProductIds: updatedSet,
    ));
  }

  Future<void> _addToCart(String productId) async {
    emit(state.copyWith(getProductStatus: Status.loading));
    final result = await _addProduct.call(productId, 1);
    switch (result) {
      case SuccessResult<CartModelEntity>():
        emit(state.copyWith(
          getProductStatus: Status.success,
          cartModelEntity: result.data,
        ));
      case FailureResult<CartModelEntity>():
        emit(state.copyWith(
          getProductStatus: Status.failure,
          errorFromGetProduct: "Something went wrong while adding to cart",
        ));
    }
  }

  bool checkProductInCart(String productId) {
    List<CartItemsEntity> products = state.cartModelEntity.cart.cartItems;
    for (var element in products) {
      if (element.product.id == productId) {
        return true;
      }
    }
    return false;
  }
}
