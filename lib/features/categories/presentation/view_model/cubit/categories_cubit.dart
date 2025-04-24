import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/categories/domain/entity/get_all_categories_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../domain/entity/get_products_by_id_entity.dart';
import '../../../domain/usecase/getCategories_use_case.dart';

part 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase _categoriesUseCase;
  CategoriesCubit(this._categoriesUseCase) : super(CategoriesInitial());

  List<ProductsEntity> _allProducts = [];
  Future<List<CategoriesEntity>> getAllCategories() async {
    try {
      final allCategories = await _categoriesUseCase.getAllCategories();

      if (allCategories.isNotEmpty) {
        final products = await _categoriesUseCase.getProductsById(allCategories[0].id ?? "");
        _allProducts = List<ProductsEntity>.from(products ?? []);
        emit(SuccessState(allCategories: allCategories, products: _allProducts));
      } else {
        _allProducts = [];
        emit(SuccessState(allCategories: allCategories, products: []));
      }

      return allCategories;
    } catch (e) {
      emit(CategoriesError('${LocaleKeys.Home_FailedToFetchCategories.tr()}${e.toString()}'));
      return [];
    }
  }

  Future<List<ProductsEntity>?> getProductsById(String categoryId) async {
    try {
      final result = await _categoriesUseCase.getProductsById(categoryId);

      _allProducts = List<ProductsEntity>.from(result ?? []);

      final currentCategories = state is SuccessState
          ? List<CategoriesEntity>.from((state as SuccessState).allCategories ?? [])
          : <CategoriesEntity>[];

      emit(SuccessState(allCategories: currentCategories, products: _allProducts));
      return _allProducts;
    } catch (e) {
      emit(CategoriesError('${LocaleKeys.Home_FailedToFetchProducts.tr()}${e.toString()}'));
      return [];
    }
  }

  void filterProducts({String? sortType, num? minPrice, num? maxPrice}) {
    minPrice = minPrice ??
        (_allProducts.isNotEmpty
            ? _allProducts.map((product) => product.price!).reduce((a, b) => a < b ? a : b)
            : 0);

    maxPrice = maxPrice ??
        (_allProducts.isNotEmpty
            ? _allProducts.map((product) => product.price!).reduce((a, b) => a > b ? a : b)
            : 0);


    List<ProductsEntity> filtered = _allProducts.where((product) {
      return product.price! >= minPrice! && product.price! <= maxPrice!;
    }).toList();


    switch (sortType) {
      case 'Lowes Price':
        filtered.sort((a, b) => a.price!.compareTo(b.price!));
        break;
      case 'Highest Price':
        filtered.sort((a, b) => b.price!.compareTo(a.price!));
        break;
      case 'New':
        filtered.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        break;
      case 'Old':
        filtered.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        break;
      case 'Discount':
        filtered.sort((a, b) => (b.discount ?? 0).compareTo(a.discount ?? 0));
        break;
    }

    final currentCategories = state is SuccessState
        ? List<CategoriesEntity>.from((state as SuccessState).allCategories ?? [])
        : <CategoriesEntity>[];

    emit(SuccessState(allCategories: currentCategories, products: filtered));
  }
}