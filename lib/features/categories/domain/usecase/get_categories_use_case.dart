import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/categories/domain/entity/get_all_categories_entity.dart';
import 'package:flowery_app/features/categories/domain/repository/get_categories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);
  final CategoriesRepository _repository;
  Future<Result<GetAllCategoriesEntity>> call() async {
    var response = await _repository.getAllCategories();
    return response;
  }
}
