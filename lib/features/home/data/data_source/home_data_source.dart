import 'package:flowery_app/features/home/domain/entity/home_entity.dart';

abstract class HomeDataSource {
  Future<HomeEntity> getHomedata();
}
