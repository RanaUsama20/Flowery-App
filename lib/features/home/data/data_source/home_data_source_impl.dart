import 'package:flowery_app/core/utils/save_local.dart';
import 'package:flowery_app/features/home/data/api/home_retrofit_client.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:injectable/injectable.dart';
import 'home_data_source.dart';

@Injectable(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final HomeRetrofitClient _homeRetrofitClient;
  HomeDataSourceImpl(this._homeRetrofitClient);
  @override
  Future<HomeEntity> getHomedata() async {
    final token = await SaveLocal.getString("token");
    final result = await _homeRetrofitClient.getHomedata(token);
    return result.toHomeEntity();
  }
}
