import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../model/categories.dart';
import '../model/product_model.dart';
part 'getl_categories_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CategoriesRetrofitClient {
  @factoryMethod
  factory CategoriesRetrofitClient(Dio dio) = _CategoriesRetrofitClient;

  @GET(ApiConstants.getAllCategories)
  Future<GetAllCategories> getAllCategories();

  @GET(ApiConstants.getProductsById)
  Future<ProductsModel> getProductsById(@Query("category") String categoryId);

  @GET(ApiConstants.getProductsById)
  Future<ProductsModel> filterToProducts({
    @Query("category") String? categoryId,
    @Query('sort') String? sort,
  });
}
