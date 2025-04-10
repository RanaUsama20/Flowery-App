import '../../domain/entity/get_all_categories_entity.dart';

class GetAllCategories {
  final List<Categories> categories;

  GetAllCategories({required this.categories});

  factory GetAllCategories.fromJson(Map<String, dynamic> json) {
    return GetAllCategories(
      categories: List<Categories>.from(json['categories'].map((x) => Categories.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'categories': List<dynamic>.from(categories.map((x) => x.toJson())),
  };

  GetAllCategoriesEntity toEntity() => GetAllCategoriesEntity(
    categories: categories.map((category) => category.toEntity()).toList(),
  );

}

class Categories {
   String id;
  String name;
  String slug;
   String image;
   String createdAt;
  String updatedAt;
   int productsCount;

  Categories({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.productsCount,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      productsCount: json['productsCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'slug': slug,
    'image': image,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'productsCount': productsCount,
  };

  CategoriesEntity toEntity() => CategoriesEntity(
    id: id,
    name: name,
    slug: slug,
    image: image,
    createdAt: createdAt,
    updatedAt: updatedAt,
    productsCount: productsCount,
  );
}
