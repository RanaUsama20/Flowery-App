part of 'occasions_cubit.dart';

extension OccasionsCubitX on OccasionsState {
  bool get isOccasionsLoading => occasionsStatus == Status.loading;
  bool get isOccasionsSuccess => occasionsStatus == Status.success;
  bool get isOccasionsFailure => occasionsStatus == Status.failure;

  bool get isProductsLoading => productsStatus == Status.loading;
  bool get isProductsSuccess => productsStatus == Status.success;
  bool get isProductsFailure => productsStatus == Status.failure;
}

class OccasionsState extends Equatable {
  final Status occasionsStatus;
  final List<OccasionEntity> occasions;
  final String occasionError;

  final Status productsStatus;
  final List<ProductItemEntity> products;
  final String productError;
  const OccasionsState({
    this.occasionsStatus = Status.initial,
    this.occasions = const [],
    this.occasionError = '',
    this.productsStatus = Status.initial,
    this.products = const [],
    this.productError = '',
  });

  OccasionsState copyWith({
    Status? occasionsStatus,
    List<OccasionEntity>? occasionsList,
    String? occasionError,
    Status? productsStatus,
    List<ProductItemEntity>? productsList,
    String? productError,
  }) =>
      OccasionsState(
        occasionsStatus: occasionsStatus ?? this.occasionsStatus,
        occasions: occasionsList ?? this.occasions,
        occasionError: occasionError ?? this.occasionError,
        productsStatus: productsStatus ?? this.productsStatus,
        products: productsList ?? this.products,
        productError: productError ?? this.productError,
      );

  @override
  List<Object> get props => [
        occasionsStatus,
        occasions,
        occasionError,
        productsStatus,
        products,
        productError,
      ];
}
