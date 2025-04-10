// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_of_category_and_best_seller_and_occasion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeOfCategoryAndBestSellerAndOccasion
    _$HomeOfCategoryAndBestSellerAndOccasionFromJson(
            Map<String, dynamic> json) =>
        HomeOfCategoryAndBestSellerAndOccasion(
          message: json['message'] as String?,
          products: (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList(),
          categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList(),
          bestSeller: (json['bestSeller'] as List<dynamic>?)
              ?.map((e) => BestSeller.fromJson(e as Map<String, dynamic>))
              .toList(),
          occasions: (json['occasions'] as List<dynamic>?)
              ?.map((e) => Occasion.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$HomeOfCategoryAndBestSellerAndOccasionToJson(
        HomeOfCategoryAndBestSellerAndOccasion instance) =>
    <String, dynamic>{
      'message': instance.message,
      'products': instance.products,
      'categories': instance.categories,
      'bestSeller': instance.bestSeller,
      'occasions': instance.occasions,
    };
