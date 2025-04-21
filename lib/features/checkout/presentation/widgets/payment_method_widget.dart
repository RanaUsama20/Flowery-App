import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/checkout/presentation/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../generated/locale_keys.g.dart';

class PaymentMethodWidget extends StatefulWidget{
  const PaymentMethodWidget({super.key});

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  String _selectedMethod = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            PaymentCard(title: LocaleKeys.checkout_Cash_on_delivery.tr(),
              selected: _selectedMethod == LocaleKeys.checkout_Cash_on_delivery,
              onTap: (){
                setState(() {
                  _selectedMethod = LocaleKeys.checkout_Cash_on_delivery;
                });
              }),
            PaymentCard(title: LocaleKeys.checkout_Credit_card.tr(),
               selected: _selectedMethod == LocaleKeys.checkout_Credit_card,
              onTap: () {
                setState(() {
                  _selectedMethod = LocaleKeys.checkout_Credit_card;
                });
              }
              ,),

          ],
        ),
      ),
    );
  }
}