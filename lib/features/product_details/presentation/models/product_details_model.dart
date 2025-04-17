class ProductDetailsModel {
  final String name;
  final String description;
  final int price;
  final bool inStock;
  final List<String> images;
  final String id;

  ProductDetailsModel({
    required this.name,
    required this.description,
    required this.price,
    required this.inStock,
    required this.images,
    required this.id
  });
}
