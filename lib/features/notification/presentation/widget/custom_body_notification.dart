import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/notification/domain/entity/all_notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBodyNotification extends StatelessWidget {
  final AllNotificationEntity item;
  const CustomBodyNotification({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SvgPicture.asset(
            SvgAssets.notificationSvg,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  item.titiel,
                  style: theme.titleSmall!.copyWith(height: 0),
                ),
                SizedBox(height: 5),
                Text(item.body,
                    style: theme.bodyLarge!.copyWith(color: AppColors.gray))
              ]))
        ]);
  }
}
