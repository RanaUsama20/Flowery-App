import 'package:injectable/injectable.dart';

import '../entity/get_all_categories_entity.dart';
import '../entity/get_products_by_id_entity.dart';
import '../repository/getCategories_repository.dart';

@injectable
class GetCategoriesUseCase {
  GetCategoriesRepository getCategoriesRepository;
  GetProductsByIdRepository getProductsByIdRepository;

  GetCategoriesUseCase(this.getCategoriesRepository, this.getProductsByIdRepository);

  Future<List<CategoriesEntity>> getAllCategories() async {
    var response = await getCategoriesRepository.getAllCategories();
    return response.categories;
  }

  Future<List<ProductsEntity>?> getProductsById(String categoryId) async {
    var response = await getProductsByIdRepository.getProductsById(categoryId);
    return response.products;
  }
}
