import 'package:equatable/equatable.dart';

class OrdersResponseEntity extends Equatable {
  final String? message;
  final List<OrdersEntity>? orders;

  const OrdersResponseEntity({this.message, this.orders});

  @override
  List<Object?> get props => [message, orders];
}

class OrdersEntity extends Equatable {
  final String? id;
  final String? user;
  final List<OrderItemsEntity>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? v;

  const OrdersEntity({
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

  @override
  List<Object?> get props => [
    id,
    user,
    orderItems,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    createdAt,
    updatedAt,
    orderNumber,
    v,
  ];
}

class OrderItemsEntity extends Equatable {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  const OrderItemsEntity({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  @override
  List<Object?> get props => [product, price, quantity, id];
}

class ProductEntity extends Equatable {
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
  final int? v;
  final int? discount;
  final int? sold;
  final double? rateAvg;
  final int? rateCount;

  const ProductEntity({
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

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    description,
    imgCover,
    images,
    price,
    priceAfterDiscount,
    quantity,
    category,
    occasion,
    createdAt,
    updatedAt,
    v,
    discount,
    sold,
    rateAvg,
    rateCount,
  ];
}
