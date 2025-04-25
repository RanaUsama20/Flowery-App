import 'package:injectable/injectable.dart';
import '../../domain/entity/get_all_categories_entity.dart';
import '../../domain/entity/get_products_by_id_entity.dart';
import '../api/getl_categories_retrofit_client.dart';
import 'getCategories_data_source.dart';

@Injectable(as: GetAllCategoriesDataSource )
class GetAllCategoriesDataSourceImpl implements GetAllCategoriesDataSource{
  final  CategoriesRetrofitClient apiService;
  GetAllCategoriesDataSourceImpl(this.apiService);

  @override
  Future<GetAllCategoriesEntity> getAllCategories() async {
    final response = await apiService.getAllCategories();
    return response.toEntity();
  }

  @override
  Future<ProductsModelEntity> getProductsById(String categoryId) async{
    final response = await apiService.getProductsById(categoryId);
    return response.toEntity();
  }


}
