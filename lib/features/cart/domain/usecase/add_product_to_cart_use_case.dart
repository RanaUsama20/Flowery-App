import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';
import 'package:flowery_app/features/cart/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartUseCase {
  final CartRepository _repository;
  const AddProductToCartUseCase(this._repository);
  Future<Result<CartModelEntity>> call(String productId, int quantity) {
    final result = _repository.addProductToCart(productId, quantity);
    return result;
  }
}
