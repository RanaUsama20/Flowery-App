import 'package:flowery_app/features/home/domain/entity/best_seller_response_entity.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';

class HomeEntity {
  final List<OccasionEntity> occasion;
  final List<CategoryEntity> category;
  final List<BestSellerEntity> bestSeller;
  HomeEntity({
    required this.bestSeller,
    required this.category,
    required this.occasion,
  });
}

class CategoryEntity {
  final String? id;
  final String? name;
  final String? image;
  CategoryEntity({required this.id, required this.image, required this.name});
}
