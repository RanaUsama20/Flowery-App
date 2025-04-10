import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
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
        Widget? actionButton,
      })

  {
    return IntrinsicWidth(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageProduct,
                  fit: BoxFit.cover,
                  height: 140,
                  width: double.infinity,
                ),
              ),
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
                    '$price EGP',
                    style: AppTheme.lightTheme.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
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
                    "$discount%",
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: AppColors.green,
                  ),
                  ),
                ],
              ),
              if (actionButton != null) ...[
                const SizedBox(height: 6),
                actionButton,
              ],
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
