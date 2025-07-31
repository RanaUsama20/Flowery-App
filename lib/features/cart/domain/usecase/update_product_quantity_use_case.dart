import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';
import 'package:flowery_app/features/cart/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProductQuantityUseCase {
  const UpdateProductQuantityUseCase(this._repository);
  final CartRepository _repository;
  Future<Result<CartModelEntity>> call(String cartItemId, int quantity) {
    final result = _repository.updateProductQuantity(cartItemId, quantity);
    return result;
  }
}
