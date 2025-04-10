import 'package:equatable/equatable.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasion_tab_response_dto.g.dart';

@JsonSerializable()
class OccasionsTabResponseDto extends Equatable {
  final String? message;
  final MetadataTabResponseDto? metadata;
  final List<OccasionTabItemResponseDto>? occasions;

  const OccasionsTabResponseDto({
    this.message,
    this.metadata,
    this.occasions,
  });

  factory OccasionsTabResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OccasionsTabResponseDtoFromJson(json);

  OccasionsEntity toEntity() => OccasionsEntity(
        message: message ?? '',
        metadata: metadata?.toEntity() ?? MetadataEntity(),
        occasions: occasions?.map((occasion) => occasion.toEntity()).toList() ?? [],
      );

  @override
  List<Object?> get props => [message, metadata, occasions];
}

@JsonSerializable()
class MetadataTabResponseDto extends Equatable {
  final num? currentPage;
  final num? limit;
  final num? totalPages;
  final num? totalItems;

  const MetadataTabResponseDto({
    this.currentPage,
    this.limit,
    this.totalPages,
    this.totalItems,
  });

  factory MetadataTabResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MetadataTabResponseDtoFromJson(json);

  MetadataEntity toEntity() => MetadataEntity(
        currentPage: currentPage ?? 0,
        limit: limit ?? 0,
        totalPages: totalPages ?? 0,
        totalItems: totalItems ?? 0,
      );

  @override
  List<Object?> get props => [currentPage, limit, totalPages, totalItems];
}

@JsonSerializable()
class OccasionTabItemResponseDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? slug;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final num? productsCount;

  const OccasionTabItemResponseDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
  });

  factory OccasionTabItemResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OccasionTabItemResponseDtoFromJson(json);

  OccasionEntity toEntity() => OccasionEntity(
        id: id ?? '',
        name: name ?? '',
        slug: slug ?? '',
        image: image ?? '',
        createdAt: createdAt ?? '',
        updatedAt: updatedAt ?? '',
        productsCount: productsCount ?? 0,
      );

  @override
  List<Object?> get props => [id, name, slug, image, createdAt, updatedAt, productsCount];
}
