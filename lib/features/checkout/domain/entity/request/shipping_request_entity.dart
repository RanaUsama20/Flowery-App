import '../../../data/model/request/shipping_request_dto.dart';

class ShippingRequestEntity {
  ShippingRequestEntity({
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


  ShippingRequestDto toDto() => ShippingRequestDto(
 street: street,
    long: long,
    lat: lat,
    city: city,
    phone: phone
  );



}