import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';

abstract class CartRepository{
  Future <CartModelEntity> getProductToCart();
  Future <CartModelEntity> addProductToCart(
      String productId,
      num quantity
      );
  Future <CartModelEntity> updateProductQuantity(String cartItemId, int quantity);
  Future <CartModelEntity> deleteProductToCart(String productId);
}
