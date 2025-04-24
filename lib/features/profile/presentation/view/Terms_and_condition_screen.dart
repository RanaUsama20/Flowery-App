import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          LocaleKeys.terms_and_conditions_terms_and_conditions.tr(),
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: const Color(0xFFD21E6A),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSection(
                title: LocaleKeys.terms_and_conditions_introduction_title.tr(),
                content: LocaleKeys.terms_and_conditions_introduction_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_use_of_app_title.tr(),
                content: LocaleKeys.terms_and_conditions_use_of_app_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_purchases_and_payments_title.tr(),
                content: LocaleKeys.terms_and_conditions_purchases_and_payments_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_delivery_title.tr(),
                content: LocaleKeys.terms_and_conditions_delivery_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_refunds_and_cancellations_title.tr(),
                content: LocaleKeys.terms_and_conditions_refunds_and_cancellations_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_intellectual_property_title.tr(),
                content: LocaleKeys.terms_and_conditions_intellectual_property_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_user_content_title.tr(),
                content: LocaleKeys.terms_and_conditions_user_content_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_limitation_of_liability_title.tr(),
                content: LocaleKeys.terms_and_conditions_limitation_of_liability_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_governing_law_title.tr(),
                content: LocaleKeys.terms_and_conditions_governing_law_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_contact_us_title.tr(),
                content: LocaleKeys.terms_and_conditions_contact_us_content.tr(),
                textTheme: textTheme,
              ),
              _buildSection(
                title: LocaleKeys.terms_and_conditions_closing_title.tr(),
                content: LocaleKeys.terms_and_conditions_closing_content.tr(),
                textTheme: textTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required TextTheme textTheme,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: const Color(0xFFD21E6A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
