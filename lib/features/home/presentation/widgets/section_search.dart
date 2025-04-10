import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_fonts_family.dart';
import 'package:flowery_app/core/constants/app_values.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SectionSearch extends StatelessWidget {
  const SectionSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
            child: Row(
          children: [
            SvgPicture.asset(SvgAssets.flowerSvg),
            SizedBox(width: 8),
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  AppValues.appTitle,
                  style: theme.labelLarge!.copyWith(
                      fontFamily: AppFontsFamily.imFelli,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        )),
        Expanded(
            flex: 2,
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: outLineBorder(),
                  focusedBorder: outLineBorder(),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.white[AppColors.colorCode70],
                  ),
                  hintText: LocaleKeys.Home_Search.tr()),
            ))
      ],
    );
  }
}

outLineBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.white[AppColors.colorCode70]!));
}
