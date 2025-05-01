import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../../core/network/remote/api_manager.dart';
import '../../../../core/utils/app_shared_preference.dart';
import '../api/cart_retrofit_client.dart';
import '../model/cart_model.dart';
import 'cart_data_source.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final CartRetrofitClient _cartRetrofitClient;
  final ApiManager _apiManager;
  CartRemoteDataSourceImpl(this._cartRetrofitClient, this._apiManager);


  @override
  Future<Result<CartModelEntity>> getProductToCart() async {
    var token = await SharedPreferencesUtils.getString(AppValues.token);
    final result = await _apiManager.execute<CartModel>(() async {
      final response = await _cartRetrofitClient.getProductToCart('Bearer $token');
      return response;

    });
    switch (result) {
      case SuccessResult<CartModel>():
        return SuccessResult<CartModelEntity>(result.data.toEntity());
      case FailureResult<CartModel>():
        return FailureResult<CartModelEntity>(result.exception);
    }
  }

  @override
  Future<Result<CartModelEntity>> addProductToCart(String productId, num quantity) async {
    var token = await SharedPreferencesUtils.getString(AppValues.token);
    final result = await _apiManager.execute<CartModel>(() async {
      final response = await _cartRetrofitClient.addProductToCart(  'Bearer $token', {"product": productId, "quantity": quantity});
      return response;

    });
    switch (result) {
      case SuccessResult<CartModel>():
        return SuccessResult<CartModelEntity>(result.data.toEntity());
      case FailureResult<CartModel>():
        return FailureResult<CartModelEntity>(result.exception);
    }
  }

  @override
  Future<Result<CartModelEntity>> updateProductQuantity(String productId, int quantity) async {
    var token = await SharedPreferencesUtils.getString(AppValues.token);
    final result = await _apiManager.execute<CartModel>(() async {
      final response = await _cartRetrofitClient.updateProductQuantity(  'Bearer $token', productId, {"quantity": quantity});
      return response;
    });
    switch (result) {
      case SuccessResult<CartModel>():
        return SuccessResult<CartModelEntity>(result.data.toEntity());
      case FailureResult<CartModel>():
        return FailureResult<CartModelEntity>(result.exception);
    }
  }
  @override
  Future<Result<CartModelEntity>> deleteProductToCart(String cartItemId) async {
    var token = await SharedPreferencesUtils.getString(AppValues.token);
    final result = await _apiManager.execute<CartModel>(() async {
      final response = await _cartRetrofitClient.deleteProductToCart('Bearer $token', cartItemId);
      return response;

    });
    switch (result) {
      case SuccessResult<CartModel>():
        return SuccessResult<CartModelEntity>(result.data.toEntity());
      case FailureResult<CartModel>():
        return FailureResult<CartModelEntity>(result.exception);
    }
  }

//
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
