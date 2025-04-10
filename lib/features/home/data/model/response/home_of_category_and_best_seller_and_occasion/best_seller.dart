import 'package:flowery_app/features/home/domain/entity/best_seller_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'best_seller.g.dart';

@JsonSerializable()
class BestSeller {
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? discount;
  int? sold;
  double? rateAvg;
  int? rateCount;

  BestSeller({
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

  factory BestSeller.fromJson(Map<String, dynamic> json) =>
      _$BestSellerFromJson(json);
  // BestSeller(
  //       title: json['title'] as String?,
  //       slug: json['slug'] as String?,
  //       description: json['description'] as String?,
  //       imgCover: json['imgCover'] as String?,
  //       images: json['images'] as List<String>?,
  //       price: json['price'] as int?,
  //       priceAfterDiscount: json['priceAfterDiscount'] as int?,
  //       quantity: json['quantity'] as int?,
  //       category: json['category'] as String?,
  //       occasion: json['occasion'] as String?,
  //       createdAt: json['createdAt'] == null
  //           ? null
  //           : DateTime.parse(json['createdAt'] as String),
  //       updatedAt: json['updatedAt'] == null
  //           ? null
  //           : DateTime.parse(json['updatedAt'] as String),
  //       v: json['__v'] as int?,
  //       discount: json['discount'] as int?,
  //       sold: json['sold'] as int?,
  //       rateAvg: (json['rateAvg'] as num?)?.toDouble(),
  //       rateCount: json['rateCount'] as int?,
  //       id: json['id'] as String?,
  //     );

  Map<String, dynamic> toJson() => _$BestSellerToJson(this);
  //       'title': title,
  //       'slug': slug,
  //       'description': description,
  //       'imgCover': imgCover,
  //       'images': images,
  //       'price': price,
  //       'priceAfterDiscount': priceAfterDiscount,
  //       'quantity': quantity,
  //       'category': category,
  //       'occasion': occasion,
  //       'createdAt': createdAt?.toIso8601String(),
  //       'updatedAt': updatedAt?.toIso8601String(),
  //       '__v': v,
  //       'discount': discount,
  //       'sold': sold,
  //       'rateAvg': rateAvg,
  //       'rateCount': rateCount,
  //       'id': id,
  //     };
  BestSellerEntity toBestSellerEntity() {
    return BestSellerEntity(
      category: category,
      createdAt: createdAt,
      description: description,
      discount: discount,
      id: id,
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
      v: v,
    );
  }
}
