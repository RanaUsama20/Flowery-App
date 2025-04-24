import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/network/remote/api_manager.dart';
import 'package:flowery_app/features/home/data/model/response/occasions/prodect_response_dto.dart';
import 'package:flowery_app/features/search/data/api/search_retrofit_client.dart';
import 'package:flowery_app/features/search/domain/data_source/search_query_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/entity/prodect_entity.dart';

@Injectable(as: SearchQueryDataSource)
class SearchQueryDataSourceImp extends SearchQueryDataSource {
  final SearchRetrofitClient _searchRetrofitClient;
  final ApiManager _apiManager;

  SearchQueryDataSourceImp(this._searchRetrofitClient, this._apiManager);
  @override
  Future<Result<ProductEntity>> getProductsByQuery(String query) async {
    final result = await _apiManager.execute<ProductResponseDto>(() async {
      return await _searchRetrofitClient.searchProduct(query);
    });
    switch (result) {
      case SuccessResult<ProductResponseDto>():
        return SuccessResult<ProductEntity>(result.data.toEntity());
      case FailureResult<ProductResponseDto>():
        return FailureResult<ProductEntity>(result.exception);
    }
  }
}
