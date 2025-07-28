class BestSellerResponseEntity {
  BestSellerResponseEntity({
    this.message,
    this.bestSeller,
  });

  String? message;
  List<BestSellerEntity>? bestSeller;
}

class BestSellerEntity {
  BestSellerEntity({
    this.title = '',
    this.slug = '',
    this.description = '',
    this.imgCover = '',
    this.images = const [],
    this.price = 0,
    this.priceAfterDiscount = 0,
    this.quantity = 0,
    this.category = '',
    this.occasion = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.v = 0,
    this.discount = 0,
    this.sold = 0,
    this.rateAvg = 0.0,
    this.rateCount = 0,
    this.id = '',
  });

  String title;
  String slug;
  String description;
  String imgCover;
  List<String> images;
  int price;
  int priceAfterDiscount;
  int quantity;
  String category;
  String occasion;
  String createdAt;
  String updatedAt;
  int v;
  int discount;
  int sold;
  double rateAvg;
  int rateCount;
  String id;
}
