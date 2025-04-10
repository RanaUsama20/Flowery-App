import 'package:flowery_app/features/categories/domain/entity/get_products_by_id_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/get_all_categories_entity.dart';
import '../../domain/repository/getCategories_repository.dart';
import '../data_source/getCategories_data_source.dart';


@Injectable(as: GetCategoriesRepository)
class GetCategoriesRepositoryImpl implements GetCategoriesRepository {
  GetAllCategoriesDataSource getCategoriesDataSource;
  GetCategoriesRepositoryImpl(this.getCategoriesDataSource,);

  Future<GetAllCategoriesEntity> getAllCategories() async {
    var response=await getCategoriesDataSource.getAllCategories();
    return response;
  }

}

@Injectable(as: GetProductsByIdRepository)
class GetProductsByIdRepositoryImpl implements GetProductsByIdRepository {
  final GetProductsByIdDataSource getProductsDataSource;

  GetProductsByIdRepositoryImpl(this.getProductsDataSource);

  @override
  Future<ProductsModelEntity> getProductsById(String categoryId) async {
    return await getProductsDataSource.getProductsById(categoryId);
  }
}

