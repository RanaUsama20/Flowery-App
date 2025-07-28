// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prodect_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseDto _$ProductResponseDtoFromJson(Map<String, dynamic> json) =>
    ProductResponseDto(
      message: json['message'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map(
              (e) => ProductItemResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductResponseDtoToJson(ProductResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'products': instance.products,
    };

ProductItemResponseDto _$ProductItemResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ProductItemResponseDto(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      imgCover: json['imgCover'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      price: json['price'] as num?,
      priceAfterDiscount: json['priceAfterDiscount'] as num?,
      quantity: json['quantity'] as num?,
      category: json['category'] as String?,
      occasion: json['occasion'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      discount: json['discount'] as num?,
      sold: json['sold'] as num?,
      rateAvg: (json['rateAvg'] as num?)?.toDouble(),
      rateCount: json['rateCount'] as num?,
    );

Map<String, dynamic> _$ProductItemResponseDtoToJson(
        ProductItemResponseDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'imgCover': instance.imgCover,
      'images': instance.images,
      'price': instance.price,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'quantity': instance.quantity,
      'category': instance.category,
      'occasion': instance.occasion,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'discount': instance.discount,
      'sold': instance.sold,
      'rateAvg': instance.rateAvg,
      'rateCount': instance.rateCount,
    };
