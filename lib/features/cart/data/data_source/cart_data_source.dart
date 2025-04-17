import '../../domain/entity/cart_data_entity.dart';

abstract class CartRemoteDataSource {
  Future<CartModelEntity> getProductToCart();

  Future<CartModelEntity> addProductToCart(String productId, num quantity);

  Future<CartModelEntity> updateProductQuantity(String productId, int quantity);

  Future<CartModelEntity> deleteProductToCart(String productId);
}
