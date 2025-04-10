import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/data/data_source/remote/home_remote_data_source.dart';
import 'package:flowery_app/features/home/data/model/response/best_seller_response_model.dart';
import 'package:flowery_app/core/network/remote/api_manager.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/best_seller/best_seller_response_entity.dart';
import '../../domain/repository/home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  final ApiManager _apiManager;
  HomeRepositoryImpl(this._apiManager, this._homeRemoteDataSource);

  @override
  Future<Result<HomeEntity>> getHomedata() async {
    final ans = await _apiManager.execute<HomeEntity>(() {
      return _homeRemoteDataSource.getHomedata();
    });
    return ans;
  }
  @override
  Future<Result<BestSellerResponseEntity>> getBestSeller() async {
    final result = await _homeRemoteDataSource.getBestSeller();

    if (result is SuccessResult<BestSellerResponseDto>) {
      return SuccessResult(result.data.toDomain());
    } else if (result is FailureResult<BestSellerResponseDto>) {
      return FailureResult(result.exception);
    }
    return FailureResult(Exception("Unknown error occurred"));

  }

}






