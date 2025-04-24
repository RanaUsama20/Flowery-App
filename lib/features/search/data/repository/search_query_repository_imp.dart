import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/search/domain/data_source/search_query_data_source.dart';
import 'package:flowery_app/features/search/domain/repository/search_query_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/entity/prodect_entity.dart';

@Injectable(as: SearchQueryRepository)
class SearchQueryRepositoryImp extends SearchQueryRepository {
  SearchQueryDataSource _dataSource;
  SearchQueryRepositoryImp(this._dataSource);
  @override
  Future<Result<List<ProductItemEntity>>> getProductsByQuery(String query) async {
    final result = await _dataSource.getProductsByQuery(query);
    switch (result) {
      case SuccessResult<ProductEntity>():
        return SuccessResult<List<ProductItemEntity>>(result.data.products);
      case FailureResult<ProductEntity>():
        return FailureResult<List<ProductItemEntity>>(result.exception);
    }
  }
}
