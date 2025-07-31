import 'package:flowery_app/features/cart/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../entity/cart_data_entity.dart';

@injectable
class DeleteProductToCartUseCase {
  final CartRepository _repository;
  const DeleteProductToCartUseCase(this._repository);

  Future<Result<CartModelEntity>> call(String productId) {
    final result = _repository.deleteProductToCart(productId);
    return result;
  }
}
