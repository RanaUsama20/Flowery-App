
import '../../../../core/network/common/api_result.dart';
import '../entity/get_all_categories_entity.dart';
import '../entity/get_products_by_id_entity.dart';

abstract class GetCategoriesRepository{
  Future<Result<GetAllCategoriesEntity>> getAllCategories();
  Future<Result<ProductsModelEntity>> getProductsById(String categoryId);
  Future<Result<ProductsModelEntity>> filterToProducts(String categoryId ,String sort);

}

