import 'package:equatable/equatable.dart';

class CartModelEntity extends Equatable {
  const CartModelEntity({
    this.message = '',
    this.numOfCartItems = 0,
    this.cart = const CartEntity(),
    this.error = '',
  });
  final String message;
  final String error;
  final num numOfCartItems;
  final CartEntity cart;

  @override
  List<Object?> get props => [message, error, numOfCartItems, cart];
}

class CartEntity extends Equatable {
  const CartEntity({
    this.id = '',
    this.user = '',
    this.cartItems = const [],
    this.discount = 0,
    this.totalPrice = 0,
    this.totalPriceAfterDiscount = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.v = 0,
  });
  final String id;
  final String user;
  final List<CartItemsEntity> cartItems;
  final num discount;
  final num totalPrice;
  final num totalPriceAfterDiscount;
  final String createdAt;
  final String updatedAt;
  final num v;

  @override
  List<Object?> get props => [
        id,
        user,
        cartItems,
        discount,
        totalPrice,
        totalPriceAfterDiscount,
        createdAt,
        updatedAt,
        v
      ];
}

class CartItemsEntity extends Equatable {
  const CartItemsEntity({
    this.product = const ProductEntity(),
    this.price = 0,
    this.quantity = 1,
    this.id = '',
  });
  final ProductEntity product;
  final num price;
  final int quantity;
  final String id;

  @override
  List<Object?> get props => [product, price, quantity, id];
}

class ProductEntity extends Equatable {
  const ProductEntity({
    this.discount = 0,
    this.price = 0,
    this.priceAfterDiscount = 0,
    this.quantity = 0,
    this.rateAvg = 0,
    this.rateCount = 0,
    this.id = '',
    this.title = '',
    this.slug = '',
    this.description = '',
    this.imgCover = '',
    this.images = const [],
    this.category = '',
    this.occasion = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.v = 0,
    this.sold = 0,
  });
  final num rateAvg;
  final num rateCount;
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final num price;
  final num priceAfterDiscount;
  final int quantity;
  final String category;
  final String occasion;
  final String createdAt;
  final String updatedAt;
  final num v;
  final num sold;
  final num discount;

  @override
  List<Object?> get props => [
        rateAvg,
        rateCount,
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
        sold,
        discount
      ];
}
