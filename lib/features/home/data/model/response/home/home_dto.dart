import 'package:flowery_app/features/home/data/model/response/best-seller/best_seller_response_model.dart';
import 'package:flowery_app/features/home/data/model/response/occasions/occasion_tab_response_dto.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'product.dart';
part 'home_dto.g.dart';

@JsonSerializable()
class HomeDto {
  String? message;
  List<Product>? products;
  List<CategoryDto>? categories;
  List<BestSellerItemDto>? bestSeller;
  List<OccasionItemDto>? occasions;

  HomeDto({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeDto.fromJson(Map<String, dynamic> json) => _$HomeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDtoToJson(this);

  HomeEntity toEntity() {
    return HomeEntity(
      bestSeller: bestSeller!.map((e) => e.toEntity()).toList(),
      category: categories!.map((e) => e.toEntity()).toList(),
      occasion: occasions!.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class CategoryDto {
  String? id;
  String? name;
  String? slug;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  CategoryEntity toEntity() {
    return CategoryEntity(id: id, image: image, name: name);
  }
}
