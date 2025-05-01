part of 'categories_cubit.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {
  final List<ProductsEntity> products;
  final List<CategoriesEntity> allCategories;

  CategoriesLoading({
    required this.products,
    required this.allCategories,
  });
}

class SuccessState extends CategoriesState {
  final List<CategoriesEntity> allCategories;
  final List<ProductsEntity> products;
  final String currentCategoryId;

  SuccessState({
    required this.allCategories,
    required this.products,
    required this.currentCategoryId,
  });
}

class CategoriesError extends CategoriesState {
  final Failure error;
  CategoriesError(this.error);
}
