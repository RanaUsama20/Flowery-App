import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'best_seller.dart';
import 'category.dart';
import 'occasion.dart';
import 'product.dart';
part 'home_of_category_and_best_seller_and_occasion.g.dart';

@JsonSerializable()
class HomeOfCategoryAndBestSellerAndOccasion {
  String? message;
  List<Product>? products;
  List<Category>? categories;
  List<BestSeller>? bestSeller;
  List<Occasion>? occasions;

  HomeOfCategoryAndBestSellerAndOccasion({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeOfCategoryAndBestSellerAndOccasion.fromJson(
          Map<String, dynamic> json) =>
      _$HomeOfCategoryAndBestSellerAndOccasionFromJson(json);
  //{
  //   return

  //    HomeOfCategoryAndBestSellerAndOccasion(
  //     message: json['message'] as String?,
  //     products: (json['products'] as List<dynamic>?)
  //         ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //     categories: (json['categories'] as List<dynamic>?)
  //         ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //     bestSeller: (json['bestSeller'] as List<dynamic>?)
  //         ?.map((e) => BestSeller.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //     occasions: (json['occasions'] as List<dynamic>?)
  //         ?.map((e) => Occasion.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //   );
  // }

  Map<String, dynamic> toJson() =>
      _$HomeOfCategoryAndBestSellerAndOccasionToJson(this);
  // {
  //       'message': message,
  //       'products': products?.map((e) => e.toJson()).toList(),
  //       'categories': categories?.map((e) => e.toJson()).toList(),
  //       'bestSeller': bestSeller?.map((e) => e.toJson()).toList(),
  //       'occasions': occasions?.map((e) => e.toJson()).toList(),
  //     };
  HomeEntity toHomeEntity() {
    return HomeEntity(
        bestSeller: bestSeller!.map(
          (e) {
            return e.toBestSellerEntity();
          },
        ).toList(),
        category: categories!.map((e) {
          return e.toCategorEntity();
        }).toList(),
        occasion: occasions!.map((e) {
          return e.toOccasionEntity();
        }).toList());
  }
}
