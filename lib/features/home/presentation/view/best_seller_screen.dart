import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../widgets/best_seller_body.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon:  SvgPicture.asset(SvgAssets.arrowBackSvg),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(LocaleKeys.Home_BestSeller.tr()),
              SizedBox(height: 3),
              Text(
                LocaleKeys.Home_BestSellerSubTitle.tr(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          )),
      body: BestSellerBody(),
    );
  }
}
