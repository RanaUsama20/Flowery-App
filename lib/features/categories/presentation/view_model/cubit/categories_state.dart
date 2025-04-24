part of 'categories_cubit.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {
  String? loadingMessage;
  CategoriesLoading([this.loadingMessage]);
}

class SuccessState extends CategoriesState {
  final List<CategoriesEntity>? allCategories;
  final List<ProductsEntity>? products;

  SuccessState({this.allCategories, this.products});
}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError(this.message);
}


class ProductsErrorState extends CategoriesState {
  final String error;

  ProductsErrorState(this.error);
}

class FilterLoadingState extends CategoriesState {}

class FilterSuccessState extends CategoriesState {}

class FilterSelectedSortState extends CategoriesState {}
