import 'package:injectable/injectable.dart';

import '../../../../core/network/common/api_result.dart';
import '../entity/get_all_categories_entity.dart';
import '../entity/get_products_by_id_entity.dart';
import '../repository/getCategories_repository.dart';

@injectable
class GetCategoriesUseCase {
  GetCategoriesRepository getCategoriesRepository;
  GetCategoriesUseCase(this.getCategoriesRepository, );

  Future<Result<GetAllCategoriesEntity>> getAllCategories() async {
    var response = await getCategoriesRepository.getAllCategories();
    return response;
  }

  Future<Result<ProductsModelEntity>> getProductsById(String categoryId) async {
    var response = await getCategoriesRepository.getProductsById(categoryId);
    return response;
  }
  Future<Result<ProductsModelEntity>> filterToProducts(String categoryId ,String sort) async {
    var response = await getCategoriesRepository.filterToProducts(categoryId ,sort);
    return response;
  }

}
