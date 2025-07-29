part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  final Status categoriesStatus;
  final List<CategoriesEntity> categories;

  final Status productsStatus;
  final List<ProductsOfCategoryEntity> products;
  final List<ProductsOfCategoryEntity> resultSearchProducts;
  final String productError;

  const CategoriesState({
    this.categoriesStatus = Status.initial,
    this.categories = const [],
    this.productsStatus = Status.initial,
    this.products = const [],
    this.productError = '',
    this.resultSearchProducts = const [],
  });

  // copyWith
  CategoriesState copyWith({
    Status? categoriesStatus,
    List<CategoriesEntity>? categories,
    Status? productsStatus,
    List<ProductsOfCategoryEntity>? products,
    String? productError,
    List<ProductsOfCategoryEntity>? resultSearchProducts,
  }) =>
      CategoriesState(
        categoriesStatus: categoriesStatus ?? this.categoriesStatus,
        categories: categories ?? this.categories,
        productsStatus: productsStatus ?? this.productsStatus,
        products: products ?? this.products,
        productError: productError ?? this.productError,
        resultSearchProducts: resultSearchProducts ?? this.resultSearchProducts,
      );

  @override
  List<Object?> get props => [
        categoriesStatus,
        categories,
        productsStatus,
        products,
        productError,
        resultSearchProducts
      ];
}

extension CategoriesStateX on CategoriesState {
  bool get isCategoriesLoading => categoriesStatus == Status.loading;
  bool get isCategoriesSuccess => categoriesStatus == Status.success;
  bool get isCategoriesFailure => categoriesStatus == Status.failure;

  bool get isProductsLoading => productsStatus == Status.loading;
  bool get isProductsSuccess => productsStatus == Status.success;
  bool get isProductsFailure => productsStatus == Status.failure;
}
