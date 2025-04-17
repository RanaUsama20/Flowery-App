import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/product_details/presentation/models/product_details_model.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/service_locator.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final ProductDetailsModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final images = product.images.isEmpty
        ? [SvgAssets.defaultPhoto1, SvgAssets.defaultPhoto2]
        : product.images;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: context.hp(50),
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      onPageChanged: (index) {
                        setState(() => _currentIndex = index);
                      },
                      itemBuilder: (context, index) {
                        return product.images.isEmpty
                            ? Image.asset(
                                images[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Image.network(
                                images[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(images.length, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? AppColors.pink
                                  : AppColors.gray,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SliverList for the content below the image
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price & Stock
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${LocaleKeys.Home_EGP.tr()} ${product.price.toStringAsFixed(2) ?? 'N/A'}",
                            style: AppTheme.lightTheme.textTheme.labelLarge!
                                .copyWith(color: AppColors.black),
                          ),
                          Row(
                            children: [
                              Text(
                                "${LocaleKeys.Home_Status.tr()}: ",
                                style: AppTheme.lightTheme.textTheme.titleSmall!
                                    .copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                product.inStock == true
                                    ? LocaleKeys.Home_InStock.tr()
                                    : LocaleKeys.Home_outStock.tr(),
                                style: AppTheme
                                    .lightTheme.textTheme.labelMedium!
                                    .copyWith(
                                  color: product.inStock == true
                                      ? AppColors.black
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: context.hp(0.5)),
                      Text(
                        LocaleKeys.Home_AllPriceIncludeTax.tr(),
                        style: AppTheme.lightTheme.textTheme.bodySmall!
                            .copyWith(color: AppColors.gray),
                      ),
                      SizedBox(height: context.hp(0.5)),
                      Text(
                        product.name,
                        style: AppTheme.lightTheme.textTheme.titleSmall!
                            .copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: context.hp(1)),
                      Text(
                        LocaleKeys.Home_Description.tr(),
                        style: AppTheme.lightTheme.textTheme.titleSmall!
                            .copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: context.hp(0.5)),
                      Text(
                        product.description,
                        style: AppTheme.lightTheme.textTheme.labelMedium!
                            .copyWith(color: AppColors.black),
                        softWrap: true,
                      ),
                      SizedBox(height: context.hp(5)),
                    ],
                  ),
                ),
              ]), // End of SliverChildListDelegate
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(child: SizedBox()),


                  BlocProvider(
                    create: (context) => serviceLocator<CartCubit>(),
                    child: BlocConsumer<CartCubit,CartState>(
                      builder: (context, state) {
                        final cartCubit = context.read<CartCubit>();
                        return   Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              cartCubit.addProductToCart(product.id.toString(),1);
                            },
                            style:
                            AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
                              minimumSize:
                              WidgetStatePropertyAll(Size(double.infinity, 48)),
                            ),
                            child: Text(LocaleKeys.Home_AddToCart.tr()),
                          ),
                        );
                      }, listener: (BuildContext context, CartState state) {
                      if(state is CartSuccessState){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.green ,
                            content: Text(state.productCart.message.toString(),
                              style: AppTheme.lightTheme.textTheme.labelSmall ,
                            ),
                          ),
                        );
                      } else if(state is CartErrorState){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.red ,
                            content: Text(LocaleKeys.Error_SoldOut.tr(),
                              style: AppTheme.lightTheme.textTheme.labelSmall ,
                            ),
                          ),
                        );
                      }


                    },
                    ),
                  ),

                ],
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(height: context.hp(2))),
            // Bottom padding
          ],
        ),
      ),
    );
  }
}
