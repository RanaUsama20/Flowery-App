
class CartModelEntity {
  String? message;
  String? error;
  num? numOfCartItems;
  CartEntity? cart;

  CartModelEntity({this.message, this.numOfCartItems, this.cart, this.error});
}

class CartEntity {
  String? id;
  String? user;
  List<CartItemsEntity>? cartItems;
  num? discount;
  num? totalPrice;
  num? totalPriceAfterDiscount;
  String? createdAt;
  String? updatedAt;
  num? v;

  CartEntity(
      {this.id,
      this.user,
      this.cartItems,
      this.discount,
      this.totalPrice,
      this.totalPriceAfterDiscount,
      this.createdAt,
      this.updatedAt,
      this.v});
}

class CartItemsEntity {
  ProductEntity? product;
  num? price;
  int? quantity;
  String? id;

  CartItemsEntity({this.product, this.price, this.quantity, this.id});
}

class ProductEntity {
  num? rateAvg;
  num? rateCount;
  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  num? price;
  num? priceAfterDiscount;
  int? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? sold;
  num? discount;

  ProductEntity(
      {this.discount,
      this.price,
      this.priceAfterDiscount,
      this.quantity,
      this.rateAvg,
      this.rateCount,
      this.id,
      this.title,
      this.slug,
      this.description,
      this.imgCover,
      this.images,
      this.category,
      this.occasion,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.sold});
}
