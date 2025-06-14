import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';

class OrderCard extends StatelessWidget {
  String? title;
  String? price;
  String? state;
  String? buttonText;
  String? imageUrl;
  String? numberOfOrder;
  OrderCard(
      {super.key,
      required this.title,
      required this.price,
      required this.state,
      required this.buttonText,
      required this.numberOfOrder,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: 319,
        height: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: AppColors.white[AppColors.colorCode90]!, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(
                  height: 109,
                  width: 127,
                  fit: BoxFit.cover,
                  imageUrl ?? PngAssets.flowerCard),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text(
                        maxLines: 1,
                        '${LocaleKeys.Home_EGP.tr()} $price',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                          maxLines: 1,
                          state ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  Routes.trackOrders,
                                  arguments: numberOfOrder);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 48, vertical: 0),
                              textStyle: const TextStyle(fontSize: 13),
                              backgroundColor:
                                  AppColors.pink[AppColors.colorCode50],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              buttonText ?? '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
