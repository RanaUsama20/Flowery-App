
import '../entity/get_all_categories_entity.dart';
import '../entity/get_products_by_id_entity.dart';

abstract class GetCategoriesRepository{
  Future<GetAllCategoriesEntity> getAllCategories();
  Future<ProductsModelEntity> getProductsById(String categoryId);
}

