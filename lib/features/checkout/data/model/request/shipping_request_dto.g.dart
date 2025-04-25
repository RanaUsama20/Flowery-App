// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingRequestDto _$ShippingRequestDtoFromJson(Map<String, dynamic> json) =>
    ShippingRequestDto(
      shippingAddress: ShippingAddressDto.fromJson(
          json['shippingAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShippingRequestDtoToJson(ShippingRequestDto instance) =>
    <String, dynamic>{
      'shippingAddress': instance.shippingAddress,
    };

ShippingAddressDto _$ShippingAddressDtoFromJson(Map<String, dynamic> json) =>
    ShippingAddressDto(
      street: json['street'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      lat: json['lat'] as String,
      long: json['long'] as String,
    );

Map<String, dynamic> _$ShippingAddressDtoToJson(ShippingAddressDto instance) =>
    <String, dynamic>{
      'street': instance.street,
      'phone': instance.phone,
      'city': instance.city,
      'lat': instance.lat,
      'long': instance.long,
    };
