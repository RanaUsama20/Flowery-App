import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:flowery_app/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class OccasionsUseCase {
  HomeRepository homeRepository;
  OccasionsUseCase(this.homeRepository);
  Future<Result<OccasionsEntity>> call() => homeRepository.getTabOccasions();
}
