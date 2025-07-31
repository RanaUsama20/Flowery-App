part of 'cart_cubit.dart';

class CartState extends Equatable {
  const CartState({
    this.getProductStatus = Status.initial,
    this.updateProductStatus = Status.initial,
    this.deleteProductStatus = Status.initial,
    this.mangeAddToCartStatus = Status.initial,
    this.cartModelEntity = const CartModelEntity(),
    this.errorFromGetProduct = '',
    this.loadingProductIds = const {},
    this.updatingProductIds = const {},
  });
  final Status getProductStatus;
  final Status updateProductStatus;
  final Status deleteProductStatus;
  final Status mangeAddToCartStatus;
  final CartModelEntity cartModelEntity;
  final String errorFromGetProduct;
  final Set<String> loadingProductIds;
  final Set<String> updatingProductIds;

  // copy with
  CartState copyWith(
          {Status? getProductStatus,
          Status? updateProductStatus,
          Status? deleteProductStatus,
          Status? mangeAddToCartStatus,
          CartModelEntity? cartModelEntity,
          String? errorFromGetProduct,
          Set<String>? loadingProductIds,
          Set<String>? updatingProductIds}) =>
      CartState(
        getProductStatus: getProductStatus ?? this.getProductStatus,
        updateProductStatus: updateProductStatus ?? this.updateProductStatus,
        deleteProductStatus: deleteProductStatus ?? this.deleteProductStatus,
        mangeAddToCartStatus: mangeAddToCartStatus ?? this.mangeAddToCartStatus,
        cartModelEntity: cartModelEntity ?? this.cartModelEntity,
        errorFromGetProduct: errorFromGetProduct ?? this.errorFromGetProduct,
        loadingProductIds: loadingProductIds ?? this.loadingProductIds,
        updatingProductIds: updatingProductIds ?? this.updatingProductIds,
      );

  @override
  List<Object?> get props => [
        getProductStatus,
        cartModelEntity,
        errorFromGetProduct,
        updateProductStatus,
        deleteProductStatus,
        mangeAddToCartStatus,
        loadingProductIds,
        updatingProductIds
      ];
}

extension CartStateX on CartState {
  bool get getProductIsLoading => getProductStatus == Status.loading;
  bool get getProductIsSuccess => getProductStatus == Status.success;
  bool get getProductIsFailure => getProductStatus == Status.failure;

  bool get updateProductIsLoading => updateProductStatus == Status.loading;
  bool get updateProductIsSuccess => updateProductStatus == Status.success;
  bool get updateProductIsFailure => updateProductStatus == Status.failure;

  bool get deleteProductIsLoading => deleteProductStatus == Status.loading;
  bool get deleteProductIsSuccess => deleteProductStatus == Status.success;
  bool get deleteProductIsFailure => deleteProductStatus == Status.failure;

  bool get mangeAddCartIsLoading => mangeAddToCartStatus == Status.loading;
  bool get mangeAddCartIsSuccess => mangeAddToCartStatus == Status.success;
  bool get mangeAddCartIsFailure => mangeAddToCartStatus == Status.failure;

  bool isProductLoading(String productId) => loadingProductIds.contains(productId);
  bool isProductUpdating(String productId) => updatingProductIds.contains(productId);
}
