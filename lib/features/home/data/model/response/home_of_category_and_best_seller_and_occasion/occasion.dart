import 'package:flowery_app/features/home/domain/entity/occasion_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'occasion.g.dart';
@JsonSerializable()
class Occasion {
  String? id;
  String? name;
  String? slug;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Occasion({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) => _$OccasionFromJson(json);
  // Occasion(
  //       id: json['_id'] as String?,
  //       name: json['name'] as String?,
  //       slug: json['slug'] as String?,
  //       image: json['image'] as String?,
  //       createdAt: json['createdAt'] == null
  //           ? null
  //           : DateTime.parse(json['createdAt'] as String),
  //       updatedAt: json['updatedAt'] == null
  //           ? null
  //           : DateTime.parse(json['updatedAt'] as String),
  //     );

  Map<String, dynamic> toJson() => _$OccasionToJson(this);
  // {
  //       '_id': id,
  //       'name': name,
  //       'slug': slug,
  //       'image': image,
  //       'createdAt': createdAt?.toIso8601String(),
  //       'updatedAt': updatedAt?.toIso8601String(),
  //     };
  OccasionEntity toOccasionEntity(){
    return OccasionEntity(id: id, image: image, name: name);
  }
}
