
import '../../../data/model/request/shipping_request_dto.dart';


class ShippingRequestEntity {
  final ShippingAddressEntity shippingAddress;

  ShippingRequestEntity({required this.shippingAddress});


  ShippingRequestDto toDto() => ShippingRequestDto(
      shippingAddress: shippingAddress.toDto()
  );


}

class ShippingAddressEntity {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;

  ShippingAddressEntity({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });



  ShippingAddressDto toDto() => ShippingAddressDto(
      street: street,
    long: long,
    lat: lat,
    city: city,
    phone: phone
  );

}



