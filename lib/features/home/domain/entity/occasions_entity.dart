import 'package:equatable/equatable.dart';

class OccasionsEntity extends Equatable {
  final String message;
  final MetadataEntity metadata;
  final List<OccasionEntity> occasions;

  const OccasionsEntity({
    required this.message,
    required this.metadata,
    required this.occasions,
  });

  @override
  List<Object?> get props => [message, metadata, occasions];
}

class MetadataEntity extends Equatable {
  final num currentPage;
  final num limit;
  final num totalPages;
  final num totalItems;

  const MetadataEntity({
    this.currentPage = 0,
    this.limit = 0,
    this.totalPages = 0,
    this.totalItems = 0,
  });

  @override
  List<Object?> get props => [currentPage, limit, totalPages, totalItems];
}

class OccasionEntity extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String image;
  final String createdAt;
  final String updatedAt;
  final num productsCount;

  const OccasionEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.productsCount,
  });

  @override
  List<Object?> get props => [id, name, slug, image, createdAt, updatedAt, productsCount];
}
