
import 'cash_order_item_entity.dart';

class CashOrderEntity {
  String? user;
  List<CashOrderItemEntity>? orderItems;
  int? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  int? v;

  CashOrderEntity({
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

}
