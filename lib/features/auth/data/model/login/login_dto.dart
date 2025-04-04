import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entity/login_entity.dart';
part 'login_dto.g.dart';

// LoginDto
@JsonSerializable()
class LoginDto {
  final String message;
  final String token;
  final UserDto user;

  LoginDto({
    required this.message,
    required this.token,
    required this.user,
  });

  /// تحويل DTO إلى Entity
  LoginEntity toLoginEntity() {
    return LoginEntity(
      message: message,
      token: token,
      user: user.toUserEntity(),
    );
  }

  factory LoginDto.fromJson(Map<String, dynamic> json) => _$LoginDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}

// UserDto
@JsonSerializable()
class UserDto {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final String role;
  final List<dynamic> wishlist;
  final List<AddressDto> addresses;
  final String createdAt;

  UserDto({
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

  /// تحويل DTO إلى Entity
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      wishlist: wishlist,
      createdAt: createdAt,
      addresses: addresses.map((e) => e.toAddressEntity()).toList(),
    );
  }

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

// AddressDto
@JsonSerializable()
class AddressDto {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;
  @JsonKey(name: '_id')
  final String id;

  AddressDto({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
    required this.id,
  });



  factory AddressDto.fromJson(Map<String, dynamic> json) => _$AddressDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  AddressEntity toAddressEntity() {
    return AddressEntity(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
      id: id,
    );
  }
}

