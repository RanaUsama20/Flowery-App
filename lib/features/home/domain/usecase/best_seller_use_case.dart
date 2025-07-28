import 'package:flowery_app/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/common/api_result.dart';
import '../entity/best_seller_response_entity.dart';

@injectable
class BestSellerUseCase {
  final HomeRepository _homeRepository;
  BestSellerUseCase(this._homeRepository);
  Future<Result<BestSellerResponseEntity>> call() async {
    final result = await _homeRepository.getBestSeller();
    return result;
  }
}
