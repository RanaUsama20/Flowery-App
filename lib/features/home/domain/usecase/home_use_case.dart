import 'package:flowery_app/features/home/domain/entity/best_seller/best_seller_response_entity.dart';
import 'package:flowery_app/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/common/api_result.dart';
@injectable
class HomeUseCase {

  final HomeRepository _homeRepository;
  HomeUseCase(this._homeRepository);
  Future<Result<BestSellerResponseEntity>> call() async {
   final result = await _homeRepository.getBestSeller();
    return result;

  }

}
