import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';

import '../../../../core/network/common/api_result.dart';

abstract class CartRepository{
  Future <Result<CartModelEntity>> getProductToCart();
  Future <Result<CartModelEntity>> addProductToCart(
      String productId,
      num quantity
      );
  Future <Result<CartModelEntity>> updateProductQuantity(String cartItemId, int quantity);
  Future <Result<CartModelEntity>> deleteProductToCart(String productId);
}
