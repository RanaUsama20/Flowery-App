import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductOccasionUseCase {
  HomeRepository homeRepository;
  ProductOccasionUseCase(this.homeRepository);
  Future<Result<ProductEntity>> call(String occasionId) =>
      homeRepository.getProductsByOccasion(occasionId);
}
