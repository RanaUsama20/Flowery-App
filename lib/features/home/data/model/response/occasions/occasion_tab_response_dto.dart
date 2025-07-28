import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasion_tab_response_dto.g.dart';

@JsonSerializable()
class OccasionsTabResponseDto {
  final String? message;

  final List<OccasionItemDto>? occasions;

  const OccasionsTabResponseDto({
    this.message,
    this.occasions,
  });

  factory OccasionsTabResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OccasionsTabResponseDtoFromJson(json);

  OccasionsResponseEntity toEntity() => OccasionsResponseEntity(
        message: message ?? '',
        occasions: occasions?.map((occasion) => occasion.toEntity()).toList() ?? [],
      );
}

@JsonSerializable()
class OccasionItemDto {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? slug;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final num? productsCount;

  const OccasionItemDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
  });

  factory OccasionItemDto.fromJson(Map<String, dynamic> json) =>
      _$OccasionItemDtoFromJson(json);

  OccasionEntity toEntity() => OccasionEntity(
        id: id ?? '',
        name: name ?? '',
        slug: slug ?? '',
        image: image ?? '',
        productsCount: productsCount ?? 0,
      );
}
