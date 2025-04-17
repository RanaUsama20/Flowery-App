// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDataDto _$ProfileDataDtoFromJson(Map<String, dynamic> json) =>
    ProfileDataDto(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileDataDtoToJson(ProfileDataDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      role: json['role'] as String?,
      wishlist: json['wishlist'] as List<dynamic>?,
      addresses: json['addresses'] as List<dynamic>?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'gender': instance.gender,
      'phone': instance.phone,
      'photo': instance.photo,
      'role': instance.role,
      'wishlist': instance.wishlist,
      'addresses': instance.addresses,
    };
