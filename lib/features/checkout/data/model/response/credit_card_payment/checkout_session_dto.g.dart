// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutSessionDto _$CheckoutSessionDtoFromJson(Map<String, dynamic> json) =>
    CheckoutSessionDto(
      message: json['message'] as String,
      session: SessionDto.fromJson(json['session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckoutSessionDtoToJson(CheckoutSessionDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'session': instance.session,
    };
