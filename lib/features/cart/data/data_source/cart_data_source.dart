import 'package:flowery_app/core/network/common/api_result.dart';

import '../../domain/entity/cart_data_entity.dart';

abstract class CartRemoteDataSource {
  Future< Result<CartModelEntity>>getProductToCart();

  Future<Result<CartModelEntity>>addProductToCart(String productId, num quantity);

  Future<Result<CartModelEntity>> updateProductQuantity(String productId, int quantity);

  Future<Result<CartModelEntity>> deleteProductToCart(String productId);
}
