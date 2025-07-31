// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponseModelDto _$CartResponseModelDtoFromJson(
        Map<String, dynamic> json) =>
    CartResponseModelDto(
      message: json['message'] as String?,
      error: json['error'] as String?,
      numOfCartItems: json['numOfCartItems'] as num?,
      cart: json['cart'] == null
          ? null
          : CartDto.fromJson(json['cart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartResponseModelDtoToJson(
        CartResponseModelDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'numOfCartItems': instance.numOfCartItems,
      'cart': instance.cart,
    };

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      cartItems: (json['cartItems'] as List<dynamic>?)
          ?.map((e) => CartItemsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      discount: json['discount'] as num?,
      totalPrice: json['totalPrice'] as num?,
      totalPriceAfterDiscount: json['totalPriceAfterDiscount'] as num?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as num?,
    );

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'cartItems': instance.cartItems,
      'discount': instance.discount,
      'totalPrice': instance.totalPrice,
      'totalPriceAfterDiscount': instance.totalPriceAfterDiscount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

CartItemsDto _$CartItemsDtoFromJson(Map<String, dynamic> json) => CartItemsDto(
      product: json['product'] == null
          ? null
          : ProductCartDto.fromJson(json['product'] as Map<String, dynamic>),
      price: json['price'] as num?,
      quantity: (json['quantity'] as num?)?.toInt(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$CartItemsDtoToJson(CartItemsDto instance) =>
    <String, dynamic>{
      'product': instance.product,
      'price': instance.price,
      'quantity': instance.quantity,
      '_id': instance.id,
    };

ProductCartDto _$ProductCartDtoFromJson(Map<String, dynamic> json) =>
    ProductCartDto(
      rateAvg: json['rateAvg'] as num?,
      rateCount: json['rateCount'] as num?,
      id: json['_id'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      imgCover: json['imgCover'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      price: json['price'] as num?,
      priceAfterDiscount: json['priceAfterDiscount'] as num?,
      quantity: (json['quantity'] as num?)?.toInt(),
      category: json['category'] as String?,
      occasion: json['occasion'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as num?,
      sold: json['sold'] as num?,
      discount: json['discount'] as num?,
    );

Map<String, dynamic> _$ProductCartDtoToJson(ProductCartDto instance) =>
    <String, dynamic>{
      'rateAvg': instance.rateAvg,
      'rateCount': instance.rateCount,
      '_id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'imgCover': instance.imgCover,
      'images': instance.images,
      'price': instance.price,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'quantity': instance.quantity,
      'category': instance.category,
      'occasion': instance.occasion,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'sold': instance.sold,
      'discount': instance.discount,
    };
