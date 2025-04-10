import 'package:flowery_app/features/home/data/api/home_retrofit_client.dart';
import 'package:flowery_app/features/home/data/model/response/best_seller_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../../../../core/network/remote/api_manager.dart';
import '../../../../../core/utils/save_local.dart';
import '../../../domain/entity/home_entity.dart';
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
    final result = await _homeRetrofitClient.getHomedata(token);
    return result.toHomeEntity();
  }

}
