
import 'cash_product_entity.dart';

class CashOrderItemEntity {
  CashProductEntity? product;
  int? price;
  int? quantity;
  String? id;

  CashOrderItemEntity({this.product, this.price, this.quantity, this.id});


}
