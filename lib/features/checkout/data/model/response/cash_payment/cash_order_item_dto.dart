import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/response/cash_payment/cash_order_item_entity.dart';
import 'cash_product_dto.dart';

part 'cash_order_item_dto.g.dart';

@JsonSerializable()
class CashOrderItemDto {
  CashProductDto? product;
  int? price;
  int? quantity;
  @JsonKey(name: '_id')
  String? id;

  CashOrderItemDto({this.product, this.price, this.quantity, this.id});

  factory CashOrderItemDto.fromJson(Map<String, dynamic> json) => _$CashOrderItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CashOrderItemDtoToJson(this);

  CashOrderItemEntity toDomain() => CashOrderItemEntity(
      id: id,
    price: price,
    quantity: quantity,
    product: product!.toDomain()
  );

}
