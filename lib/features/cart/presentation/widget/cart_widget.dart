import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flowery_app/features/cart/domain/entity/cart_data_entity.dart';
import 'package:flowery_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemsEntity packageProduct;
  final int index;
  final void Function()? onTapDelete;
  final void Function()? onClickProduct;
  final Animation<double> animation;

  const CartItemWidget({
    super.key,
    required this.packageProduct,
    required this.index,
    required this.animation,
    this.onTapDelete,
    this.onClickProduct,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      key: UniqueKey(),
      position:
          Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
      child: InkWell(
        onTap: onClickProduct,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.gray,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            spacing: 10,
            children: [
              CustomCacheNetworkImage(
                key: UniqueKey(),
                imageUrl: packageProduct.product.imgCover,
                height: 95,
                width: 80,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(8),
              ),
              Expanded(
                child: Column(
                  spacing: 8,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 3,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                packageProduct.product.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                packageProduct.product.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: onTapDelete,
                          child: SvgPicture.asset(
                            SvgAssets.deleteSvg,
                            colorFilter:
                                ColorFilter.mode(AppColors.pink, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      buildWhen: (previous, current) =>
                          previous.updateProductStatus != current.updateProductStatus,
                      builder: (context, state) {
                        final isUpdating =
                            state.isProductUpdating(packageProduct.product.id);
                        final productItem = state.cartModelEntity.cart.cartItems[index];
                        return Row(
                          spacing: 3,
                          children: [
                            Text(
                              " ${(productItem.product.price * productItem.quantity).toString()}  ${LocaleKeys.Home_EGP.tr()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                if (productItem.quantity == 1) return;
                                await context.read<CartCubit>().updateProductQuantity(
                                      productItem.product.id,
                                      productItem.quantity - 1,
                                    );
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 24,
                              ),
                            ),
                            isUpdating
                                ? const SizedBox(
                                    height: 11,
                                    width: 11,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  )
                                : Text(
                                    productItem.quantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                            InkWell(
                              onTap: () async {
                                await context.read<CartCubit>().updateProductQuantity(
                                      productItem.product.id,
                                      productItem.quantity + 1,
                                    );
                              },
                              child: const Icon(
                                Icons.add,
                                size: 24,
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
