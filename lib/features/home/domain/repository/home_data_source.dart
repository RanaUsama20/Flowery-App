import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';

abstract class HomeDataSource {
  Future<Result<OccasionsEntity>> getTabOccasions();
  Future<Result<ProductEntity>> getProductsByOccasion(String occasionId);
}
