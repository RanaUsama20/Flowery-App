import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.about_app_about_app_title.tr(),
                style: textTheme.titleMedium?.copyWith(color: const Color(0xFFD21E6A)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.about_app_about_app.tr(),
                style: textTheme.bodyLarge?.copyWith(color: const Color(0xFF333333)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.about_app_our_story_title.tr(),
                style: textTheme.titleMedium?.copyWith(color: const Color(0xFFD21E6A)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.about_app_our_story.tr(),
                style: textTheme.bodyLarge?.copyWith(color: const Color(0xFF333333)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.about_app_what_we_offer_title.tr(),
                style: textTheme.titleMedium?.copyWith(color: const Color(0xFFD21E6A)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.about_app_what_we_offer.tr(),
                style: textTheme.bodyLarge?.copyWith(color: const Color(0xFF333333)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.about_app_our_commitment_title.tr(),
                style: textTheme.titleMedium?.copyWith(color: const Color(0xFFD21E6A)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.about_app_our_commitment.tr(),
                style: textTheme.bodyLarge?.copyWith(color: const Color(0xFF333333)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.about_app_get_in_touch_title.tr(),
                style: textTheme.titleMedium?.copyWith(color: const Color(0xFFD21E6A)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.about_app_get_in_touch.tr(),
                style: textTheme.bodyLarge?.copyWith(color: const Color(0xFF333333)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                LocaleKeys.about_app_closing_title.tr(),
                style: textTheme.titleMedium?.copyWith(color: const Color(0xFFD21E6A)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.about_app_closing.tr(),
                style: textTheme.bodyLarge?.copyWith(color: const Color(0xFF333333)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
