import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_values.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  bool valueLang = false;
  @override
  Widget build(BuildContext context) {
    String currentLang = context.locale.languageCode;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            LocaleKeys.profile_changeLanguage.tr(),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.pink,
                  fontWeight: FontWeight.bold,
                ),
          ),
          _buildLanguageRadio(
            title: LocaleKeys.profile_Arabic.tr(),
            value: AppValues.arabic,
            groupValue: currentLang,
          ),
          _buildLanguageRadio(
            title: LocaleKeys.profile_English.tr(),
            value: AppValues.english,
            groupValue: currentLang,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLanguageRadio({
    required String title,
    required String value,
    required String groupValue,
  }) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        context.setLocale(Locale(value));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
            const Spacer(),
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: (val) {
                if (val != null) {
                  context.setLocale(Locale(val));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
