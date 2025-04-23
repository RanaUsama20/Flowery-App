import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/enum/state_user.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/theme/app_theme.dart';
import 'package:flowery_app/core/utils/widgets/card.dart';
import 'package:flowery_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/product_details/presentation/models/product_details_model.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: BlocProvider(
            create: (context) => serviceLocator<CartCubit>(),
            child: BlocConsumer<CartCubit, CartState>(
              builder: (context, state) {
                final cartCubit = context.read<CartCubit>();
                return ProductCard.createProductCard(
                  widget.products[index].imgCover,
                  widget.products[index].title,
                  widget.products[index].price.toInt(),
                  widget.products[index].priceAfterDiscount.toInt(),
                  widget.products[index].discount.toInt(),
                  onAddToCart: () {
                    if (_appCubit.getStateUser == StateUser.guest) {
                      AppDialogs.showLoginDialog(context,
                          message: LocaleKeys.Error_YouHaveToLoginToUseThisFeature.tr());
                    } else {
                      cartCubit.addProductToCart(widget.products[index].id.toString(), 1);
                    }
                  },
                  productId: widget.products[index].id.toString(),
                );
              },
              listener: (BuildContext context, CartState state) {
                if (state is CartSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.green,
                      content: Text(
                        state.productCart.message.toString(),
                        style: AppTheme.lightTheme.textTheme.labelSmall,
                      ),
                    ),
                  );
                } else if (state is CartErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.red,
                      content: Text(
                        LocaleKeys.Error_SoldOut.tr(),
                        style: AppTheme.lightTheme.textTheme.labelSmall,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
