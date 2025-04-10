import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/network/remote/api_manager.dart';
import 'package:flowery_app/features/home/data/api/home_retrofit_client.dart';
import 'package:flowery_app/features/home/data/models/response/occasion_tab_response_dto.dart';
import 'package:flowery_app/features/home/data/models/response/prodect_response_dto.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/home_data_source.dart';

@Injectable(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final HomeRetrofitClient apiService;
  final ApiManager apiManager;
  HomeDataSourceImpl(this.apiService, this.apiManager);

  @override
  Future<Result<OccasionsEntity>> getTabOccasions() async {
    Result<OccasionsTabResponseDto> result =
        await apiManager.execute<OccasionsTabResponseDto>(() async {
      return await apiService.getTabOccasions();
    });

    switch (result) {
      case SuccessResult<OccasionsTabResponseDto>():
        return SuccessResult<OccasionsEntity>(result.data.toEntity());
      case FailureResult<OccasionsTabResponseDto>():
        return FailureResult<OccasionsEntity>(result.exception);
    }
  }

  @override
  Future<Result<ProductEntity>> getProductsByOccasion(String occasionId) async {
    final result = await apiManager.execute<ProductResponseDto>(() async {
      return await apiService.getProductsByOccasion(occasionId);
    });

    switch (result) {
      case SuccessResult<ProductResponseDto>():
        return SuccessResult<ProductEntity>(result.data.toEntity());
      case FailureResult<ProductResponseDto>():
        return FailureResult<ProductEntity>(result.exception);
    }
  }
}
