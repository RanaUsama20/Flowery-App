import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/response/cash_payment/cash_product_entity.dart';

part 'cash_product_dto.g.dart';

@JsonSerializable()
class CashProductDto {
  @JsonKey(name: '_id')
  String? id;
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

  CashProductDto({
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
    this.v,
    this.discount,
    this.sold,
    this.rateAvg,
    this.rateCount,
  });

  factory CashProductDto.fromJson(Map<String, dynamic> json) =>
      _$CashProductDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CashProductDtoToJson(this);

  CashProductEntity toDomain() => CashProductEntity(
      quantity: quantity,
      price: price,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
      id: id,
      images: images,
      description: description,
      title: title,
      sold: sold,
      slug: slug,
      rateCount: rateCount,
      rateAvg: rateAvg,
      priceAfterDiscount: priceAfterDiscount,
      occasion: occasion,
      imgCover: imgCover,
      discount: discount,
      category: category);
}
