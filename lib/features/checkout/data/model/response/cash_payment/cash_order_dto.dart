import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/response/cash_payment/cash_order_entity.dart';
import 'cash_order_item_dto.dart';

part 'cash_order_dto.g.dart';

@JsonSerializable()
class CashOrderDto {
  String? user;
  List<CashOrderItemDto>? orderItems;
  int? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  @JsonKey(name: '__v')
  int? v;

  CashOrderDto({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory CashOrderDto.fromJson(Map<String, dynamic> json) =>
      _$CashOrderDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CashOrderDtoToJson(this);

  CashOrderEntity toDomain() => CashOrderEntity(
      id: id,
      v: v,
      updatedAt: updatedAt,
      createdAt: createdAt,
      user: user,
      isDelivered: isDelivered,
      isPaid: isPaid,
      orderItems: orderItems?.map((e) => e.toDomain()).toList(),
      orderNumber: orderNumber,
      paymentType: paymentType,
      state: state,
      totalPrice: totalPrice);
}
