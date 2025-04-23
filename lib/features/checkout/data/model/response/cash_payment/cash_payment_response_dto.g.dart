// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_payment_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashPaymentResponseDto _$CashPaymentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CashPaymentResponseDto(
      message: json['message'] as String?,
      order: json['order'] == null
          ? null
          : CashOrderDto.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CashPaymentResponseDtoToJson(
        CashPaymentResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'order': instance.order,
    };
