import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';

class DeliveryTimeWidget extends StatelessWidget {
  const DeliveryTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.checkout_Delivery_time.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  LocaleKeys.checkout_Schedule.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600, color: AppColors.pink),
                ),
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                SvgPicture.asset(SvgAssets.blackScheduleSvg),
                Text(LocaleKeys.checkout_Delivery_time_sub1.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.w600)),
                Text(
                  LocaleKeys.checkout_Delivery_time_sub2.tr(),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.green, fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
