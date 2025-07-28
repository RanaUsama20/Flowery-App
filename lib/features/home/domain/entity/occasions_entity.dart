import 'package:equatable/equatable.dart';

class OccasionsResponseEntity extends Equatable {
  final String message;
  final List<OccasionEntity> occasions;

  const OccasionsResponseEntity({
    required this.message,
    required this.occasions,
  });

  @override
  List<Object?> get props => [message, occasions];
}

class OccasionEntity extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String image;
  final num productsCount;

  const OccasionEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.productsCount,
  });

  @override
  List<Object?> get props => [id, name, slug, image, productsCount];
}
