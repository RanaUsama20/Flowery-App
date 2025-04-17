import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flutter/material.dart';
import '../../../generated/locale_keys.g.dart';
import '../../theme/app_theme.dart';

class ProductCard {
  static Widget createProductCard(
      String imageProduct,
      String title,
      int price,
      int oldPrice,
      int discount, {
        required String productId,
        int quantity = 1,
        required void Function() onAddToCart,
      }) {
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
          padding: const EdgeInsets.all(7.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomCacheNetworkImage(
                  imageUrl: imageProduct,
                  height: 140,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$price ${LocaleKeys.Home_EGP.tr()}',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$oldPrice',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$discount%',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ActionButton(onPressed: onAddToCart),
            ],
          ),
        ),
      ),
    );
  }
}


class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          padding: MaterialStatePropertyAll(EdgeInsets.all(6)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 16, color: Colors.white),
            SizedBox(width: 12),
            Text(LocaleKeys.Home_AddToCart.tr(),
                style: AppTheme.lightTheme.textTheme.labelSmall
                    ?.copyWith(color: AppColors.white)),
          ],
        ),
      ),
    );
  }
}
