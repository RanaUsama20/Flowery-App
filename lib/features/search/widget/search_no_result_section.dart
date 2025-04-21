import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class SearchNoResultSection extends StatelessWidget {
  const SearchNoResultSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Image.asset(
              PngAssets.emptySearch,
              width: double.infinity,
            ),
            SizedBox(height: 16),
            Text(
              LocaleKeys.search_titleEmptySearch.tr(),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Text(
              LocaleKeys.search_desEmptySearch.tr(),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: AppColors.black[AppColors.colorCode30]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
