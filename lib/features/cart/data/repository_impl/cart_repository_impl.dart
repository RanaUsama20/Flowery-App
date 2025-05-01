import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../../domain/repository/cart_repository.dart';
import '../data_source/cart_data_source.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _cartRemoteDataSource;
  CartRepositoryImpl (this._cartRemoteDataSource);

  @override
  Future<Result<CartModelEntity>> addProductToCart(String productId, num quantity)async {
   final result = await _cartRemoteDataSource.addProductToCart(productId, quantity);
   return result;
  }

  @override
  Future<Result<CartModelEntity>> getProductToCart()async {
    final result = await _cartRemoteDataSource.getProductToCart();
    return result;
  }
 @override
  Future<Result<CartModelEntity>> updateProductQuantity(String productId, int quantity)async {
   final result = await _cartRemoteDataSource.updateProductQuantity(productId, quantity);
   return result;
 }

  @override
  Future<Result<CartModelEntity>> deleteProductToCart(String productId)async {
   final result = await _cartRemoteDataSource.deleteProductToCart(productId);
   return result;
  }

}
