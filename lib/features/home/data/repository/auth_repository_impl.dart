import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/home/domain/repository/home_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeDataSource dataSource;
  HomeRepositoryImpl(this.dataSource);

  @override
  Future<Result<OccasionsEntity>> getTabOccasions() {
    return dataSource.getTabOccasions();
  }

  @override
  Future<Result<ProductEntity>> getProductsByOccasion(String occasionId) {
    return dataSource.getProductsByOccasion(occasionId);
  }
}
