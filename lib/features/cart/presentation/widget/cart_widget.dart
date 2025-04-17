import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../generated/locale_keys.g.dart';

class CartItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final num? price;
  final num? quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: IntrinsicWidth(
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTheme.lightTheme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            price!.toStringAsFixed(0),
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            LocaleKeys.Home_EGP.tr(),
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        color: AppColors.red,
                        size: 24,
                      ),
                      onPressed: onRemove,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            size: 24,
                          ),
                          onPressed: onDecrement,
                        ),
                        Text(quantity.toString(),
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 24,
                          ),
                          onPressed: onIncrement,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
