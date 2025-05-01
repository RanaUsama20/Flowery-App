import 'package:flowery_app/features/categories/domain/entity/get_products_by_id_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../../domain/entity/get_all_categories_entity.dart';
import '../../domain/repository/getCategories_repository.dart';
import '../data_source/getCategories_data_source.dart';


@Injectable(as: GetCategoriesRepository)
class GetCategoriesRepositoryImpl implements GetCategoriesRepository {
  GetAllCategoriesDataSource getCategoriesDataSource;
  GetCategoriesRepositoryImpl(this.getCategoriesDataSource,);

  @override
  Future<Result<GetAllCategoriesEntity>> getAllCategories() async {
    var response=await getCategoriesDataSource.getAllCategories();
    return response;
  }


  @override
  Future<Result<ProductsModelEntity>> getProductsById(String categoryId) async {
    return await getCategoriesDataSource.getProductsById(categoryId);
  }

  @override
  Future<Result<ProductsModelEntity>> filterToProducts(String categoryId ,String sort)  async{
    return await getCategoriesDataSource.filterToProducts(categoryId ,sort);
  }


}


