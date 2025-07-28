// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasion_tab_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccasionsTabResponseDto _$OccasionsTabResponseDtoFromJson(
        Map<String, dynamic> json) =>
    OccasionsTabResponseDto(
      message: json['message'] as String?,
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => OccasionItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OccasionsTabResponseDtoToJson(
        OccasionsTabResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'occasions': instance.occasions,
    };

OccasionItemDto _$OccasionItemDtoFromJson(Map<String, dynamic> json) =>
    OccasionItemDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      productsCount: json['productsCount'] as num?,
    );

Map<String, dynamic> _$OccasionItemDtoToJson(OccasionItemDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'productsCount': instance.productsCount,
    };
