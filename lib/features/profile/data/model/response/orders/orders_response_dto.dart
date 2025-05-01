import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/orders/orders_entity.dart';

part 'orders_response_dto.g.dart';

@JsonSerializable()
class OrdersResponseDto {
  final String? message;
  final List<OrdersDto>? orders;

  OrdersResponseDto({this.message, this.orders});

  factory OrdersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseDtoToJson(this);
  OrdersResponseEntity toDomain() => OrdersResponseEntity(
      message: message,
    orders: orders?.map((item) => item.toDomain()).toList(),


  );
}

@JsonSerializable()
class OrdersDto {
  @JsonKey(name: '_id')
  final String? id;
  final String? user;
  final List<OrderItemsDto>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  @JsonKey(name: '__v')
  final int? v;

  OrdersDto({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory OrdersDto.fromJson(Map<String, dynamic> json) =>
      _$OrdersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersDtoToJson(this);

  OrdersEntity toDomain() => OrdersEntity(
     id: id,
    v: v,
    updatedAt: updatedAt,
    createdAt: createdAt,
    totalPrice: totalPrice,
    state: state,
    paymentType: paymentType,
    orderNumber: orderNumber,
      orderItems: orderItems?.map((item) => item.toDomain()).toList(),
    isPaid: isPaid,
    isDelivered: isDelivered,
    user: user


  );
}

@JsonSerializable()
class OrderItemsDto {
  final ProductDto? product;
  final int? price;
  final int? quantity;
  @JsonKey(name: '_id')
  final String? id;

  OrderItemsDto({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory OrderItemsDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsDtoToJson(this);
  OrderItemsEntity toDomain() => OrderItemsEntity(
      id: id,
     price: price,
    quantity: quantity,
    product: product!.toDomain()


  );

}

@JsonSerializable()
class ProductDto {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  final int? discount;
  final int? sold;
  final double? rateAvg;
  final int? rateCount;

  ProductDto({
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

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
  ProductEntity toDomain() => ProductEntity(
      id: id,
      price: price,
      quantity: quantity,
    createdAt: createdAt,
    updatedAt: updatedAt,
    v: v,
    category: category,
    discount: discount,
    imgCover: imgCover,
    occasion: occasion,
    priceAfterDiscount: priceAfterDiscount,
    rateAvg: rateAvg,
    rateCount: rateCount,
    slug: slug,
    sold: sold,
    title: title,
    description: description,
    images: images



  );
}