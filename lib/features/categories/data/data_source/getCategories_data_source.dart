
import '../../domain/entity/get_all_categories_entity.dart';
import '../../domain/entity/get_products_by_id_entity.dart';

abstract class GetAllCategoriesDataSource {
  Future<GetAllCategoriesEntity>getAllCategories();

}
abstract class GetProductsByIdDataSource {
  Future<ProductsModelEntity>getProductsById(String categoryId);

}