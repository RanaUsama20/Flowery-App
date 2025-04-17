// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordResponseDto _$ChangePasswordResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResponseDto(
      message: json['message'] as String?,
      token: json['token'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ChangePasswordResponseDtoToJson(
        ChangePasswordResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'error': instance.error,
    };
