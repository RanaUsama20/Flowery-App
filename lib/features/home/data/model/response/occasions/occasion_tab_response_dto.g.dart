// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasion_tab_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccasionsTabResponseDto _$OccasionsTabResponseDtoFromJson(
        Map<String, dynamic> json) =>
    OccasionsTabResponseDto(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : MetadataTabResponseDto.fromJson(
              json['metadata'] as Map<String, dynamic>),
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) =>
              OccasionTabItemResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OccasionsTabResponseDtoToJson(
        OccasionsTabResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'occasions': instance.occasions,
    };

MetadataTabResponseDto _$MetadataTabResponseDtoFromJson(
        Map<String, dynamic> json) =>
    MetadataTabResponseDto(
      currentPage: json['currentPage'] as num?,
      limit: json['limit'] as num?,
      totalPages: json['totalPages'] as num?,
      totalItems: json['totalItems'] as num?,
    );

Map<String, dynamic> _$MetadataTabResponseDtoToJson(
        MetadataTabResponseDto instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'limit': instance.limit,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
    };

OccasionTabItemResponseDto _$OccasionTabItemResponseDtoFromJson(
        Map<String, dynamic> json) =>
    OccasionTabItemResponseDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      productsCount: json['productsCount'] as num?,
    );

Map<String, dynamic> _$OccasionTabItemResponseDtoToJson(
        OccasionTabItemResponseDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'productsCount': instance.productsCount,
    };
