import 'package:flowery_app/features/home/domain/entity/best_seller_response_entity.dart';
import 'package:flowery_app/features/home/domain/repository/home_repository.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeUseCase {
  final HomeRepository _homeRepository;
  HomeUseCase(this._homeRepository);
  Future<Result<HomeEntity>> call() => _homeRepository.getHomedata();
}
