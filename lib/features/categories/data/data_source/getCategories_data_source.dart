
import '../../../../core/network/common/api_result.dart';
import '../../domain/entity/get_all_categories_entity.dart';
import '../../domain/entity/get_products_by_id_entity.dart';

abstract class GetAllCategoriesDataSource {
  Future<Result<GetAllCategoriesEntity>>getAllCategories();
  Future<Result<ProductsModelEntity>>getProductsById(String categoryId);
  Future<Result<ProductsModelEntity>>filterToProducts(String categoryId ,String sort);

}
