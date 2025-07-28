// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_seller_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestSellerResponseDto _$BestSellerResponseDtoFromJson(
        Map<String, dynamic> json) =>
    BestSellerResponseDto(
      message: json['message'] as String?,
      bestSeller: (json['bestSeller'] as List<dynamic>?)
          ?.map((e) => BestSellerItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BestSellerResponseDtoToJson(
        BestSellerResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'bestSeller': instance.bestSeller,
    };

BestSellerItemDto _$BestSellerItemDtoFromJson(Map<String, dynamic> json) =>
    BestSellerItemDto(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      imgCover: json['imgCover'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      price: (json['price'] as num?)?.toInt(),
      priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      category: json['category'] as String?,
      occasion: json['occasion'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      sold: (json['sold'] as num?)?.toInt(),
      rateAvg: (json['rateAvg'] as num?)?.toDouble(),
      rateCount: (json['rateCount'] as num?)?.toInt(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$BestSellerItemDtoToJson(BestSellerItemDto instance) =>
    <String, dynamic>{
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
      '__v': instance.v,
      'discount': instance.discount,
      'sold': instance.sold,
      'rateAvg': instance.rateAvg,
      'rateCount': instance.rateCount,
      '_id': instance.id,
    };
