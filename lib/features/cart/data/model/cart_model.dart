import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/cart_data_entity.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartResponseModelDto {
  const CartResponseModelDto({
    this.message,
    this.error,
    this.numOfCartItems,
    this.cart,
  });

  factory CartResponseModelDto.fromJson(Map<String, dynamic> json) =>
      _$CartResponseModelDtoFromJson(json);

  final String? message;
  final String? error;
  final num? numOfCartItems;
  final CartDto? cart;
  Map<String, dynamic> toJson() => _$CartResponseModelDtoToJson(this);

  CartModelEntity toEntity() => CartModelEntity(
        error: error ?? '',
        message: message ?? '',
        numOfCartItems: numOfCartItems ?? 0,
        cart: cart?.toEntity() ?? CartEntity(),
      );
}

@JsonSerializable()
class CartDto {
  const CartDto({
    this.id,
    this.user,
    this.cartItems,
    this.discount,
    this.totalPrice,
    this.totalPriceAfterDiscount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
  factory CartDto.fromJson(Map<String, dynamic> json) => _$CartDtoFromJson(json);
  @JsonKey(name: '_id')
  final String? id;
  final String? user;
  final List<CartItemsDto>? cartItems;
  final num? discount;
  final num? totalPrice;
  final num? totalPriceAfterDiscount;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final num? v;

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);

  CartEntity toEntity() => CartEntity(
        id: id ?? '',
        user: user ?? '',
        cartItems: cartItems?.map((v) => v.toEntity()).toList() ?? [],
        discount: discount ?? 0,
        totalPrice: totalPrice ?? 0,
        totalPriceAfterDiscount: totalPriceAfterDiscount ?? 0,
        createdAt: createdAt ?? '',
        updatedAt: updatedAt ?? '',
        v: v ?? 0,
      );
}

@JsonSerializable()
class CartItemsDto {
  const CartItemsDto({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory CartItemsDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemsDtoFromJson(json);
  final ProductCartDto? product;
  final num? price;
  final int? quantity;
  @JsonKey(name: '_id')
  final String? id;

  Map<String, dynamic> toJson() => _$CartItemsDtoToJson(this);

  CartItemsEntity toEntity() => CartItemsEntity(
        product: product?.toEntity() ?? ProductEntity(),
        price: price ?? 0,
        quantity: quantity ?? 0,
        id: id ?? '',
      );
}

@JsonSerializable()
class ProductCartDto {
  const ProductCartDto({
    this.rateAvg,
    this.rateCount,
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
    this.sold,
    this.discount,
  });

  factory ProductCartDto.fromJson(Map<String, dynamic> json) =>
      _$ProductCartDtoFromJson(json);
  final num? rateAvg;
  final num? rateCount;
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final num? price;
  final num? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final num? v;
  final num? sold;
  final num? discount;

  Map<String, dynamic> toJson() => _$ProductCartDtoToJson(this);

  ProductEntity toEntity() => ProductEntity(
        rateAvg: rateAvg ?? 0,
        rateCount: rateCount ?? 0,
        id: id ?? '',
        title: title ?? '',
        slug: slug ?? '',
        description: description ?? '',
        imgCover: imgCover ?? '',
        images: images ?? [],
        price: price ?? 0,
        priceAfterDiscount: priceAfterDiscount ?? 0,
        quantity: quantity ?? 0,
        category: category ?? '',
        occasion: occasion ?? '',
        createdAt: createdAt ?? '',
        updatedAt: updatedAt ?? '',
        v: v ?? 0,
        sold: sold ?? 0,
        discount: discount ?? 0,
      );
}
