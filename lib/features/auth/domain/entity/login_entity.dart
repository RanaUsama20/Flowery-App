

class LoginEntity {
  String? message;
  String? token;
  UserEntity? user;

  LoginEntity({this.message, this.user, this.token});

}


class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final String role;
  final List<dynamic> wishlist;
  final List<AddressEntity> addresses;
  final String createdAt;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.wishlist,
    required this.addresses,
    required this.createdAt,
  });
}

class AddressEntity {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;
  final String id;

  AddressEntity({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
    required this.id,
  });
}
