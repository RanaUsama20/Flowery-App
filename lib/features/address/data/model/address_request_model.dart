class AddressRequestModel {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String userName;

  AddressRequestModel(
      {required this.street,
      required this.phone,
      required this.city,
      required this.lat,
      required this.long,
      required this.userName});

  Map<String, dynamic> toJson() => {
        "street": street,
        "phone": phone,
        "lat": lat,
        "long": long,
        "username": userName,
        "city": city
      };
}
