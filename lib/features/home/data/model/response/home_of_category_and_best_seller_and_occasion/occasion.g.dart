// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Occasion _$OccasionFromJson(Map<String, dynamic> json) => Occasion(
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

Map<String, dynamic> _$OccasionToJson(Occasion instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
