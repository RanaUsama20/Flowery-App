import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/categories/domain/entity/get_all_categories_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/failuer.dart';
import '../../../../../core/network/common/api_result.dart';
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
      final result = await _categoriesUseCase.getAllCategories();

      if (result is SuccessResult<GetAllCategoriesEntity>) {
        final allCategories = result.data.categories;
        if (allCategories.isNotEmpty) {
          final productsResult = await _categoriesUseCase.getProductsById(allCategories[0].id);
          if (productsResult is SuccessResult<ProductsModelEntity>) {
            _allProducts = productsResult.data.products ?? [];
            emit(SuccessState(
              allCategories: allCategories,
              products: _allProducts,
              currentCategoryId: allCategories[0].id,
            ));
          } else if (productsResult is FailureResult<ProductsModelEntity>) {
            final failure = _extractFailure(productsResult.exception);
            emit(CategoriesError(failure.message as Failure));
          }
        } else {
          emit(SuccessState(
            allCategories: [],
            products: [],
            currentCategoryId: '',
          ));
        }
        return allCategories;
      } else if (result is FailureResult<GetAllCategoriesEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CategoriesError(failure.message as Failure));
        return [];
      }
    } catch (e) {
      emit(CategoriesError(LocaleKeys.Home_FailedToFetchCategories.tr() as Failure));
      return [];
    }
    return [];
  }

  Future<List<ProductsEntity>?> getProductsById(String categoryId) async {
    try {
      final result = await _categoriesUseCase.getProductsById(categoryId);

      if (result is SuccessResult<ProductsModelEntity>) {
        _allProducts = result.data.products ?? [];

        final currentCategories = state is SuccessState
            ? (state as SuccessState).allCategories
            : <CategoriesEntity>[];

        emit(SuccessState(
          allCategories: currentCategories,
          products: _allProducts,
          currentCategoryId: categoryId,
        ));
        return _allProducts;
      } else if (result is FailureResult<ProductsModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CategoriesError(failure.message as Failure));
        return [];
      }
    } catch (e) {
      emit(CategoriesError(LocaleKeys.Home_FailedToFetchProducts.tr() as Failure));
      return [];
    }
    return null;
  }

  Future<List<ProductsEntity>?> filterToProducts({
    required String categoryId,
    required String sort,
  }) async {
    final currentState = state;

    if (currentState is SuccessState) {
      emit(CategoriesLoading(
        products: currentState.products,
        allCategories: currentState.allCategories,
      ));
    }

    try {
      final result = await _categoriesUseCase.filterToProducts(categoryId, sort);

      if (result is SuccessResult<ProductsModelEntity>) {
        _allProducts = result.data.products ?? [];

        final currentCategories = currentState is SuccessState
            ? currentState.allCategories
            : <CategoriesEntity>[];

        emit(SuccessState(
          allCategories: currentCategories,
          products: _allProducts,
          currentCategoryId: categoryId,
        ));
        return _allProducts;
      } else if (result is FailureResult<ProductsModelEntity>) {
        final failure = _extractFailure(result.exception);
        emit(CategoriesError(failure.message as Failure));
        return [];
      }
    } catch (e) {
      emit(CategoriesError(LocaleKeys.Home_FailedToFetchProducts.tr() as Failure));
      return [];
    }
    return null;
  }

  Failure _extractFailure(Object exception) {
    if (exception is Failure) {
      return exception;
    }
    return ServerFailure(LocaleKeys.Error_Bad_request.tr());
  }
}
