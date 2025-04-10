import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entity/best_seller/best_seller_response_entity.dart';
import 'best_seller_model.dart';

part 'best_seller_response_model.g.dart';

@JsonSerializable()
class BestSellerResponseDto {
  String? message;
  List<BestSellerDto>? bestSeller;

  BestSellerResponseDto({this.message, this.bestSeller});

  factory BestSellerResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerResponseDtoToJson(this);
  BestSellerResponseEntity toDomain() => BestSellerResponseEntity(
   message: message,
   bestSeller: bestSeller?.map((dto) => dto.toDomain()).toList() ?? [],
  );


}
