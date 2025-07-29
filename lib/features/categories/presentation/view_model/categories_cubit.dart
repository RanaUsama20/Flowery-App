import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/enum/status.dart';
import 'package:flowery_app/features/categories/domain/entity/get_all_categories_entity.dart';
import 'package:flowery_app/features/categories/domain/usecase/filter_product_use_case.dart';
import 'package:flowery_app/features/categories/domain/usecase/get_product_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/common/api_result.dart';
import '../../domain/entity/get_products_by_id_entity.dart';
import '../../domain/usecase/get_categories_use_case.dart';

part 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(
    this._categoriesUseCase,
    this._getProductUseCase,
    this._filterProductUseCase,
  ) : super(CategoriesState());
  final GetCategoriesUseCase _categoriesUseCase;
  final GetProductUseCase _getProductUseCase;
  final FilterProductUseCase _filterProductUseCase;

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesStatus: Status.loading));
    final result = await _categoriesUseCase.call();
    switch (result) {
      case SuccessResult<GetAllCategoriesEntity>():
        await getProductsByCategory(result.data.categories[0].id);
        emit(state.copyWith(
          categories: result.data.categories,
          categoriesStatus: Status.success,
        ));
      case FailureResult<GetAllCategoriesEntity>():
        emit(state.copyWith(
          categoriesStatus: Status.failure,
        ));
    }
  }

  Future<void> getProductsByCategory(String categoryId) async {
    emit(state.copyWith(productsStatus: Status.loading));
    final result = await _getProductUseCase.call(categoryId);
    switch (result) {
      case SuccessResult<ProductsOfCategoryResponseEntity>():
        emit(state.copyWith(
          products: result.data.products,
          productsStatus: Status.success,
        ));
      case FailureResult<ProductsOfCategoryResponseEntity>():
        emit(state.copyWith(
          productsStatus: Status.failure,
          productError: 'Something went wrong',
        ));
    }
  }

  Future<void> filterProduct(String categoryId, String sort) async {
    emit(state.copyWith(productsStatus: Status.loading));
    final result = await _filterProductUseCase.call(categoryId, sort);
    switch (result) {
      case SuccessResult<ProductsOfCategoryResponseEntity>():
        emit(state.copyWith(
          products: result.data.products,
          productsStatus: Status.success,
        ));
      case FailureResult<ProductsOfCategoryResponseEntity>():
        emit(state.copyWith(
          productsStatus: Status.failure,
          productError: 'Something went wrong',
        ));
    }
  }

  void searchProduct(String query) async {
    // search and return new list of products
    emit(state.copyWith(productsStatus: Status.loading));

    var newList = state.products
        .where((element) => element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(state.copyWith(
      productsStatus: Status.success,
      resultSearchProducts: newList,
    ));
  }
}
