// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordResponseDto _$ForgotPasswordResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponseDto(
      message: json['message'] as String?,
      info: json['info'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordResponseDtoToJson(
        ForgotPasswordResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'info': instance.info,
    };
