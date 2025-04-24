import 'package:flowery_app/core/network/common/api_result.dart';

import '../../../home/domain/entity/prodect_entity.dart';

abstract class SearchQueryRepository {
  Future<Result<List<ProductItemEntity>>> getProductsByQuery(String query);
}
