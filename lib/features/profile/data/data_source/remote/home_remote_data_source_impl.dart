import 'package:flowery_app/features/home/data/api/home_retrofit_client.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/remote/api_manager.dart';

import 'home_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSource)
class HomeRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final HomeRetrofitClient _homeRetrofitClient;
  final ApiManager _apiManager;

  HomeRemoteDataSourceImpl(this._homeRetrofitClient, this._apiManager);
  //! ex:
  // @override
  // Future<Result<ModelEntity>> functionName() async {
  //   final result = await _apiManager.execute<ModelDto>(() async {
  //     return await _homeRetrofitClient.functionName();
  //   });
  //   switch (result) {
  //     case SuccessResult<ModelDto>():
  //       return SuccessResult<ModelEntity>(result.data.toEntity());
  //     case FailureResult<ModelDto>():
  //       return FailureResult<ProductEntity>(result.exception);
  //   }
  // }
}
