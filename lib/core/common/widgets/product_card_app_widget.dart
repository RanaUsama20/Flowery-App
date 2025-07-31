import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flowery_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/locale_keys.g.dart';
import '../../theme/app_theme.dart';

class ProductCardAppWidget extends StatefulWidget {
  const ProductCardAppWidget({
    super.key,
    required this.imageProduct,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.productId,
    this.quantity = 1,
  });

  final String imageProduct;
  final String title;
  final int price;
  final int oldPrice;
  final int discount;
  final String productId;
  final int quantity;

  @override
  State<ProductCardAppWidget> createState() => _ProductCardAppWidgetState();
}

class _ProductCardAppWidgetState extends State<ProductCardAppWidget> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.white[AppColors.colorCode70]!,
            width: 0.5,
          ),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCacheNetworkImage(
                imageUrl: widget.imageProduct,
                height: 140,
                fit: BoxFit.cover,
                width: double.infinity,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${widget.price} ${LocaleKeys.Home_EGP.tr()}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          widget.oldPrice.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.discount}%',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    BlocProvider(
                      create: (context) => serviceLocator<CartCubit>(),
                      child: ActionButton(productId: widget.productId),
                    ),
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

class ActionButton extends StatefulWidget {
  const ActionButton({super.key, required this.productId});
  final String productId;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          previous.mangeAddCartIsLoading != current.mangeAddCartIsLoading ||
          previous.loadingProductIds != current.loadingProductIds,
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        return SizedBox(
          height: 30,
          child: ElevatedButton(
            key: ValueKey(widget.productId),
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  backgroundColor: WidgetStatePropertyAll(AppColors.pink),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  padding: WidgetStatePropertyAll(EdgeInsets.all(6)),
                ),
            onPressed: () async {
              await cubit.mangeAddToCart(widget.productId);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                state.mangeAddCartIsLoading
                    ? SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(Icons.shopping_cart_outlined, size: 16, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  cubit.checkProductInCart(widget.productId)
                      ? 'Remove'
                      : LocaleKeys.Home_AddToCart.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
