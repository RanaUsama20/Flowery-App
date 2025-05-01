import 'package:flowery_app/features/cart/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../entity/cart_data_entity.dart';
@injectable
class CartUseCase {
  CartRepository cartRepository ;
   CartUseCase( this.cartRepository);
   Future <Result<CartModelEntity>> getProductToCart(){
     final result = cartRepository.getProductToCart();
     return result;
   }
   Future <Result<CartModelEntity>> addProductToCart(String productId,num quantity){
     final result = cartRepository.addProductToCart(productId, quantity);
     return result;
   }
   Future <Result<CartModelEntity>> updateProductQuantity(String cartItemId, int quantity){
     final result = cartRepository.updateProductQuantity(cartItemId, quantity);
     return result;
   }
   Future <Result<CartModelEntity>> deleteProductToCart(String productId){
     final result = cartRepository.deleteProductToCart(productId);
     return result;
   }
}