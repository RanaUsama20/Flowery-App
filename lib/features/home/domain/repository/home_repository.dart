import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';

abstract class HomeRepository {
  Future<Result<HomeEntity>>getHomedata();
}
