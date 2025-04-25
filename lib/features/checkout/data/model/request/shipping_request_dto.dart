import 'package:json_annotation/json_annotation.dart';

part 'shipping_request_dto.g.dart';

@JsonSerializable()
class ShippingRequestDto {
  final ShippingAddressDto shippingAddress;

  ShippingRequestDto({required this.shippingAddress});

  factory ShippingRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingRequestDtoToJson(this);
}

@JsonSerializable()
class ShippingAddressDto {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;

  ShippingAddressDto({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });

  factory ShippingAddressDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressDtoToJson(this);
}
