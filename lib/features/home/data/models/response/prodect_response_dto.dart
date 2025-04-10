import 'package:flowery_app/features/home/data/models/response/occasion_tab_response_dto.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prodect_response_dto.g.dart';

@JsonSerializable()
class ProductResponseDto {
  final String? message;
  final MetadataTabResponseDto? metadata;
  final List<ProductItemResponseDto>? products;

  ProductResponseDto({
    this.message,
    this.metadata,
    this.products,
  });

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDtoFromJson(json);
  ProductEntity toEntity() => ProductEntity(
        message: message ?? '',
        metadata: metadata?.toEntity() ?? MetadataEntity(),
        products: products?.map((product) => product.toEntity()).toList() ?? [],
      );
}

@JsonSerializable()
class ProductItemResponseDto {
  @JsonKey(name: "_id")
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final num? price;
  final num? priceAfterDiscount;
  final num? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final num? discount;
  final num? sold;
  final double? rateAvg;
  final num? rateCount;

  ProductItemResponseDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.discount,
    this.sold,
    this.rateAvg,
    this.rateCount,
  });

  factory ProductItemResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductItemResponseDtoFromJson(json);

  ProductItemEntity toEntity() => ProductItemEntity(
        id: id ?? '',
        title: title ?? '',
        slug: slug ?? '',
        description: description ?? '',
        imgCover: imgCover ?? '',
        images: images ?? [],
        price: price ?? 0.0,
        priceAfterDiscount: priceAfterDiscount ?? 0.0,
        quantity: quantity ?? 0.0,
        category: category ?? '',
        occasion: occasion ?? '',
        createdAt: createdAt ?? '',
        updatedAt: updatedAt ?? '',
        discount: discount ?? 0.0,
        sold: sold ?? 0.0,
        rateAvg: rateAvg ?? 0.0,
        rateCount: rateCount ?? 0.0,
      );
}
