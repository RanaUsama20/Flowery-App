
import 'package:json_annotation/json_annotation.dart';

part 'shipping_request_dto.g.dart';

@JsonSerializable()
class ShippingRequestDto {
  ShippingRequestDto({
      this.street, 
      this.phone, 
      this.city, 
      this.lat, 
      this.long,});


  String? street;
  String? phone;
  String? city;
  String? lat;
  String? long;

  factory ShippingRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingRequestDtoToJson(this);




}