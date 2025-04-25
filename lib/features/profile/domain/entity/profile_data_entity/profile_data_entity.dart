import 'package:equatable/equatable.dart';

class ProfileDataEntity extends Equatable {
  final String message;
  final UserEntity user;

  const ProfileDataEntity({
    this.message = '',
    this.user = const UserEntity(),
  });

  @override
  List<Object?> get props => [message, user];
}

class UserEntity extends Equatable {
  final String sId;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final String role;
  final List wishlist;
  final List<AddressEntity> addresses;

  const UserEntity({
    this.sId = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.gender = '',
    this.phone = '',
    this.photo = '',
    this.role = '',
    this.wishlist = const [],
    this.addresses = const [],
  });

  @override
  List<Object?> get props => [
        sId,
        firstName,
        lastName,
        email,
        gender,
        phone,
        photo,
        role,
        wishlist,
        addresses,
      ];
}

class AddressEntity extends Equatable {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;
  final String? id;

  const AddressEntity({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });


  @override
  List<Object?> get props => [street, phone, city, lat, long, username, id];
}

