import 'package:flowery_app/features/home/domain/entity/best_seller/best_seller_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_seller_model.g.dart';

@JsonSerializable()
class BestSellerDto {
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

  BestSellerDto({
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

  factory BestSellerDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerDtoToJson(this);

  BestSellerEntity toDomain() => BestSellerEntity(
      id: id,
    description: description,
    category: category,
    createdAt: createdAt,
    discount: discount,
    images: images,
    imgCover: imgCover,
    occasion: occasion,
    price: price,
    priceAfterDiscount: priceAfterDiscount,
    quantity: quantity,
    rateAvg: rateAvg,
    rateCount: rateCount,
    slug: slug,
    sold: sold,
    title: title,
    updatedAt: updatedAt,
    v: v
  );

}
