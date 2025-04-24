import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';

class ProductEntity {
  final String message;
  final MetadataEntity metadata;
  final List<ProductItemEntity> products;

  ProductEntity({
    required this.message,
    required this.metadata,
    required this.products,
  });
}

class ProductItemEntity {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final num price;
  final num priceAfterDiscount;
  final num quantity;
  final String category;
  final String occasion;
  final String createdAt;
  final String updatedAt;
  final num discount;
  final num sold;
  final double rateAvg;
  final num rateCount;

  const ProductItemEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.discount,
    required this.sold,
    required this.rateAvg,
    required this.rateCount,
  });
}
