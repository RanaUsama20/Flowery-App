import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/entity/best_seller_response_entity.dart';

part 'best_seller_response_model.g.dart';

@JsonSerializable()
class BestSellerResponseDto {
  String? message;
  List<BestSellerItemDto>? bestSeller;

  BestSellerResponseDto({this.message, this.bestSeller});

  factory BestSellerResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerResponseDtoToJson(this);
  BestSellerResponseEntity toEntity() => BestSellerResponseEntity(
        message: message,
        bestSeller: bestSeller?.map((dto) => dto.toEntity()).toList() ?? [],
      );
}

@JsonSerializable()
class BestSellerItemDto {
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  int? price;
  int? priceAfterDiscount;
  int? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  @JsonKey(name: '__v')
  int? v;
  int? discount;
  int? sold;
  double? rateAvg;
  int? rateCount;
  @JsonKey(name: '_id')
  String? id;

  BestSellerItemDto({
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
    this.v,
    this.discount,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.id,
  });

  factory BestSellerItemDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerItemDtoToJson(this);

  BestSellerEntity toEntity() => BestSellerEntity(
        id: id ?? '',
        description: description ?? '',
        category: category ?? '',
        createdAt: createdAt ?? '',
        discount: discount ?? 0,
        images: images ?? [],
        imgCover: imgCover ?? '',
        occasion: occasion ?? '',
        price: price ?? 0,
        priceAfterDiscount: priceAfterDiscount ?? 0,
        quantity: quantity ?? 0,
        rateAvg: rateAvg ?? 0,
        rateCount: rateCount ?? 0,
        slug: slug ?? '',
        sold: sold ?? 0,
        title: title ?? '',
        updatedAt: updatedAt ?? '',
        v: v ?? 0,
      );
}
