import 'package:flowery_app/features/home/domain/entity/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';
@JsonSerializable()

class Category {
  String? id;
  String? name;
  String? slug;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  
  
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  CategoryEntity toCategorEntity(){
    return CategoryEntity(id: id, image: image, name: name);
  }
}