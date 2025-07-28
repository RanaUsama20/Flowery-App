// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDto _$HomeDtoFromJson(Map<String, dynamic> json) => HomeDto(
      message: json['message'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      bestSeller: (json['bestSeller'] as List<dynamic>?)
          ?.map((e) => BestSellerItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => OccasionItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeDtoToJson(HomeDto instance) => <String, dynamic>{
      'message': instance.message,
      'products': instance.products,
      'categories': instance.categories,
      'bestSeller': instance.bestSeller,
      'occasions': instance.occasions,
    };

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => CategoryDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
