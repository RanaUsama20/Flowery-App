// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDto _$SessionDtoFromJson(Map<String, dynamic> json) => SessionDto(
      id: json['id'] as String,
      object: json['object'] as String,
      amount_subtotal: (json['amount_subtotal'] as num).toInt(),
      amount_total: (json['amount_total'] as num).toInt(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      payment_status: json['payment_status'] as String,
      customer_email: json['customer_email'] as String?,
      url: json['url'] as String,
    );

Map<String, dynamic> _$SessionDtoToJson(SessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'amount_subtotal': instance.amount_subtotal,
      'amount_total': instance.amount_total,
      'currency': instance.currency,
      'status': instance.status,
      'payment_status': instance.payment_status,
      'customer_email': instance.customer_email,
      'url': instance.url,
    };
