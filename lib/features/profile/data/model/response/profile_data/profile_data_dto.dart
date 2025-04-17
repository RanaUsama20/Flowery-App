import 'package:equatable/equatable.dart';
import 'package:flowery_app/features/profile/domain/entity/profile_data_entity/profile_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

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

  //? to entity
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
  final List? addresses;

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
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  //? to entity
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
        addresses: addresses ?? [],
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
