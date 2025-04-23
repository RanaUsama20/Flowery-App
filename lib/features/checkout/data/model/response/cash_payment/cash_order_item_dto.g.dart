// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_order_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashOrderItemDto _$CashOrderItemDtoFromJson(Map<String, dynamic> json) =>
    CashOrderItemDto(
      product: json['product'] == null
          ? null
          : CashProductDto.fromJson(json['product'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$CashOrderItemDtoToJson(CashOrderItemDto instance) =>
    <String, dynamic>{
      'product': instance.product,
      'price': instance.price,
      'quantity': instance.quantity,
      '_id': instance.id,
    };
