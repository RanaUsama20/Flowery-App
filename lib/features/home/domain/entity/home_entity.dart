import 'package:flowery_app/features/home/domain/entity/best_seller_entity.dart';
import 'package:flowery_app/features/home/domain/entity/category_entity.dart';
import 'package:flowery_app/features/home/domain/entity/occasion_entity.dart';

class HomeEntity {
  final List<OccasionEntity> occasion;
  final List<CategoryEntity> category;
  final List<BestSellerEntity> bestSeller;
  HomeEntity(
      {required this.bestSeller,
      required this.category,
      required this.occasion});
}
