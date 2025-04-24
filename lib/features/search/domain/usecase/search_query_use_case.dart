import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/search/domain/repository/search_query_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/entity/prodect_entity.dart';

@injectable
class SearchQueryUseCase {
  SearchQueryRepository repository;

  SearchQueryUseCase(this.repository);

  Future<Result<List<ProductItemEntity>>> call(String query) =>
      repository.getProductsByQuery(query);
}
