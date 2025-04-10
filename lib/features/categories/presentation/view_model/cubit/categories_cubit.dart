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

  Future<List<CategoriesEntity>> getAllCategories() async {
    try {
      final allCategories = await _categoriesUseCase.getAllCategories();
      await getProductsById(allCategories[0].id);
      emit(SuccessState(allCategories: allCategories));
      return allCategories;
    } catch (e) {
      emit(CategoriesError( LocaleKeys.Home_FailedToFetchCategories.tr() + '${e.toString()}'));
      return [];
    }
  }


  Future<List<ProductsEntity>?> getProductsById(String categoryId) async {
    try {
      final result = await _categoriesUseCase.getProductsById(categoryId);
      final products = result ?? [];

      final currentCategories = state is SuccessState
          ? List<CategoriesEntity>.from((state as SuccessState).allCategories ?? [])
          : <CategoriesEntity>[];

      emit(SuccessState(allCategories: currentCategories, products: products));
      return products;
    } catch (e) {

      emit(CategoriesError(LocaleKeys.Home_FailedToFetchProducts.tr() + '${e.toString()}'));
      return [];
    }
   }

}