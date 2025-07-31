import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/common/widgets/product_card_app_widget.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/product_details/presentation/models/product_details_model.dart';
import 'package:flutter/material.dart';

class ResultsSearches extends StatefulWidget {
  const ResultsSearches({super.key, required this.products});
  final List<ProductItemEntity> products;

  @override
  State<ResultsSearches> createState() => _ResultsSearchesState();
}

class _ResultsSearchesState extends State<ResultsSearches> {
  late AppCubit _appCubit;
  @override
  void initState() {
    super.initState();
    _appCubit = serviceLocator.get<AppCubit>();
    // _tabController = TabController(length: 10, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: widget.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 260,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final mappedProduct = ProductDetailsModel(
          id: widget.products[index].id.toString(),
          price: widget.products[index].price.toInt(),
          description: widget.products[index].description,
          name: widget.products[index].title,
          images: widget.products[index].images,
          inStock: widget.products[index].quantity != 0 ? true : false,
        );
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.productDetails, arguments: mappedProduct);
          },
          child: ProductCardAppWidget(
            imageProduct: widget.products[index].imgCover,
            title: widget.products[index].title,
            price: widget.products[index].price.toInt(),
            oldPrice: widget.products[index].priceAfterDiscount.toInt(),
            discount: widget.products[index].discount.toInt(),
            productId: widget.products[index].id.toString(),
          ),
        );
      },
    );
  }
}
