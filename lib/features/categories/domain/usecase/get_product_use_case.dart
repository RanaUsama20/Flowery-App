import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/categories/domain/entity/get_products_by_id_entity.dart';
import 'package:flowery_app/features/categories/domain/repository/get_categories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductUseCase {
  const GetProductUseCase(this._repository);
  final CategoriesRepository _repository;

  Future<Result<ProductsOfCategoryResponseEntity>> call(String categoryId) async {
    var response = await _repository.getProductsById(categoryId);
    return response;
  }
}
