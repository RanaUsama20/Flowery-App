import '../../domain/entity/get_products_by_id_entity.dart';


class ProductsModel {
  final String? message;
  final List<Products>? products;

  const ProductsModel({
    this.message,
    this.products,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      message: json['message'],
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'products': products?.map((v) => v.toJson()).toList(),
    };
  }

  ProductsModelEntity toEntity() => ProductsModelEntity(
    message: message,
    products: products?.map((v) => v.toEntity()).toList(),
  );
}


class Products {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final num? price;
  final num? priceAfterDiscount;
  final num? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final num? v;
  final num? discount;
  final num? sold;
  final num? rateAvg;
  final num? rateCount;

  const Products({
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

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'], // change to '_id' if needed
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      imgCover: json['imgCover'],
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      price: json['price'],
      priceAfterDiscount: json['priceAfterDiscount'],
      quantity: json['quantity'],
      category: json['category'],
      occasion: json['occasion'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      discount: json['discount'],
      sold: json['sold'],
      rateAvg: json['rateAvg'],
      rateCount: json['rateCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'imgCover': imgCover,
      'images': images,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'quantity': quantity,
      'category': category,
      'occasion': occasion,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'discount': discount,
      'sold': sold,
      'rateAvg': rateAvg,
      'rateCount': rateCount,
    };
  }

  ProductsEntity toEntity() => ProductsEntity(
    id: id,
    title: title,
    slug: slug,
    description: description,
    imgCover: imgCover,
    images: images,
    price: price,
    priceAfterDiscount: priceAfterDiscount,
    quantity: quantity,
    category: category,
    occasion: occasion,
    createdAt: createdAt,
    updatedAt: updatedAt,
    v: v,
    discount: discount,
    sold: sold,
    rateAvg: rateAvg,
    rateCount: rateCount,
  );
}