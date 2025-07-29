import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../../core/network/remote/api_manager.dart';
import '../../domain/entity/get_all_categories_entity.dart';
import '../../domain/entity/get_products_by_id_entity.dart';
import '../api/getl_categories_retrofit_client.dart';
import '../model/categories.dart';
import '../model/product_model.dart';
import 'getCategories_data_source.dart';

@Injectable(as: GetAllCategoriesDataSource)
class GetAllCategoriesDataSourceImpl implements GetAllCategoriesDataSource {
  final CategoriesRetrofitClient apiService;
  final ApiManager apiManager;
  GetAllCategoriesDataSourceImpl(this.apiService, this.apiManager);

  @override
  Future<Result<GetAllCategoriesEntity>> getAllCategories() async {
    final result = await apiManager.execute<GetAllCategories>(() async {
      final response = await apiService.getAllCategories();
      return response;
    });
    switch (result) {
      case SuccessResult<GetAllCategories>():
        return SuccessResult<GetAllCategoriesEntity>(result.data.toEntity());
      case FailureResult<GetAllCategories>():
        return FailureResult<GetAllCategoriesEntity>(result.exception);
    }
  }

  @override
  Future<Result<ProductsOfCategoryResponseEntity>> getProductsById(
      String categoryId) async {
    final result = await apiManager.execute<ProductsModel>(() async {
      final response = await apiService.getProductsById(categoryId);
      return response;
    });
    switch (result) {
      case SuccessResult<ProductsModel>():
        return SuccessResult<ProductsOfCategoryResponseEntity>(result.data.toEntity());
      case FailureResult<ProductsModel>():
        return FailureResult<ProductsOfCategoryResponseEntity>(result.exception);
    }
  }

  @override
  Future<Result<ProductsOfCategoryResponseEntity>> filterToProducts(
      String categoryId, String sort) async {
    final result = await apiManager.execute<ProductsModel>(() async {
      final response =
          await apiService.filterToProducts(categoryId: categoryId, sort: sort);
      return response;
    });
    switch (result) {
      case SuccessResult<ProductsModel>():
        return SuccessResult<ProductsOfCategoryResponseEntity>(result.data.toEntity());
      case FailureResult<ProductsModel>():
        return FailureResult<ProductsOfCategoryResponseEntity>(result.exception);
    }
  }

// @override
// Future<Result<ModelEntity>> functionName() async {
//   final result = await _apiManager.execute<ModelDto>(() async {
//     return await _homeRetrofitClient.functionName();
//   });
//   switch (result) {
//     case SuccessResult<ModelDto>():
//       return SuccessResult<ModelEntity>(result.data.toEntity());
//     case FailureResult<ModelDto>():
//       return FailureResult<ProductEntity>(result.exception);
//   }
// }
}
