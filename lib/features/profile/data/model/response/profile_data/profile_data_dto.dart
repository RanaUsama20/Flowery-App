import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/profile_data_entity/profile_data_entity.dart';

part 'profile_data_dto.g.dart';

@JsonSerializable()
class ProfileDataDto extends Equatable {
  final String? message;
  final UserDto? user;

  const ProfileDataDto({
    this.message,
    this.user,
  });

  factory ProfileDataDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataDtoFromJson(json);

  ProfileDataEntity toProfileDataEntity() => ProfileDataEntity(
    message: message ?? '',
    user: user!.toEntity(),
  );

  @override
  List<Object?> get props => [message, user];
}

@JsonSerializable()
class UserDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final List? wishlist;

  @JsonKey(defaultValue: [])
  final List<AddressDto>? addresses;

  const UserDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  UserEntity toEntity() => UserEntity(
    sId: id ?? '',
    firstName: firstName ?? '',
    lastName: lastName ?? '',
    email: email ?? '',
    gender: gender ?? '',
    phone: phone ?? '',
    photo: photo ?? '',
    role: role ?? '',
    wishlist: wishlist ?? [],
    addresses: addresses?.map((e) => e.toEntity()).toList() ?? [],
  );

  @override
  List<Object?> get props => [
    id,
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

@JsonSerializable()
class AddressDto extends Equatable {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;

  @JsonKey(name: '_id')
  final String? id;

  const AddressDto({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  AddressEntity toEntity() => AddressEntity(
    phone: phone,
    id: id,
    city: city,
    lat: lat,
    long: long,
    street: street,
    username: username

  );

  @override
  List<Object?> get props => [street, phone, city, lat, long, username, id];
}
