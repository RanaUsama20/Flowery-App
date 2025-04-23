import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/checkout/presentation/widgets/payment_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../generated/locale_keys.g.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodSelected;

  const PaymentMethodWidget({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              LocaleKeys.checkout_Payment_method.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            PaymentCard(
              title: LocaleKeys.checkout_Cash_on_delivery.tr(),
              selected: selectedMethod == LocaleKeys.checkout_Cash_on_delivery.tr(),
              onTap: () {
                onMethodSelected(LocaleKeys.checkout_Cash_on_delivery.tr());
              },
            ),
            PaymentCard(
              title: LocaleKeys.checkout_Credit_card.tr(),
              selected: selectedMethod == LocaleKeys.checkout_Credit_card.tr(),
              onTap: () {
                onMethodSelected(LocaleKeys.checkout_Credit_card.tr());
              },
            ),
          ],
        ),
      ),
    );
  }
}
