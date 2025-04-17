class ProductDetailsModel {
  final String id;
  final String name;
  final String description;
  final int price;
  final bool inStock;
  final List<String> images;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.inStock,
    required this.images,
  });
}
