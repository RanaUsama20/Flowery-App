import 'package:flowery_app/features/home/data/api/home_retrofit_client.dart';
import 'package:flowery_app/features/home/data/model/response/best-seller/best_seller_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../../../../core/network/remote/api_manager.dart';
import '../../../../../core/utils/save_local.dart';
import '../../../domain/entity/home_entity.dart';
import '../../../domain/entity/occasions_entity.dart';
import '../../../domain/entity/prodect_entity.dart';
import '../../model/response/occasions/occasion_tab_response_dto.dart';
import '../../model/response/occasions/prodect_response_dto.dart';
import 'home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeRetrofitClient _homeRetrofitClient;
  final ApiManager _apiManager;

  HomeRemoteDataSourceImpl(this._homeRetrofitClient, this._apiManager);

  @override
  Future<Result<BestSellerResponseDto>> getBestSeller() async {
    final response = await _apiManager.execute<BestSellerResponseDto>(
      () async {
        return await _homeRetrofitClient.getBestSeller();
      },
    );

    return response;
  }

  @override
  Future<HomeEntity> getHomedata() async {
    final token = await SaveLocal.getString("token");
    print('token from home $token');
    final result = await _homeRetrofitClient.getHomedata(token);
    return result.toHomeEntity();
  }

  @override
  Future<Result<OccasionsEntity>> getTabOccasions() async {
    Result<OccasionsTabResponseDto> result =
        await _apiManager.execute<OccasionsTabResponseDto>(() async {
      return await _homeRetrofitClient.getTabOccasions();
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
    final result = await _apiManager.execute<ProductResponseDto>(() async {
      return await _homeRetrofitClient.getProductsByOccasion(occasionId);
    });

    switch (result) {
      case SuccessResult<ProductResponseDto>():
        return SuccessResult<ProductEntity>(result.data.toEntity());
      case FailureResult<ProductResponseDto>():
        return FailureResult<ProductEntity>(result.exception);
    }
  }
}
