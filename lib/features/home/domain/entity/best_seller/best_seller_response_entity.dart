import 'best_seller_entity.dart';

class BestSellerResponseEntity {
  BestSellerResponseEntity({
    this.message,
    this.bestSeller,});

  String? message;
  List<BestSellerEntity>? bestSeller;

}