import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/network/remote/api_manager.dart';
import 'package:flowery_app/features/home/data/data_source/home_data_source.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final ApiManager _apiManager;
  final HomeDataSource _homeDataSource;
  HomeRepositoryImpl(this._apiManager, this._homeDataSource);

  @override
  Future<Result<HomeEntity>> getHomedata() async {
    final ans = await _apiManager.execute<HomeEntity>(() {
      return _homeDataSource.getHomedata();
    });
    return ans;
  }
}
