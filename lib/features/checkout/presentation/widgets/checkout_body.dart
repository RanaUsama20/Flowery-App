import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/features/checkout/presentation/widgets/payment_method_widget.dart';
import 'package:flutter/material.dart';

import 'bottom_widget.dart';
import 'custom_radio_button.dart';
import 'delivery_address_widget.dart';
import 'delivery_time_widget.dart';
import 'gift_widget.dart';

class CheckoutBody extends StatelessWidget {
  const CheckoutBody({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          DeliveryTimeWidget(),
          SizedBox(
            height: 24,
          ),
          // DeliveryAddressWidget(),
          DeliveryAddressWidget(),
          SizedBox(
            height: 24,
          ),
          PaymentMethodWidget(),
          SizedBox(
            height: 24,
          ),
          GiftWidget(),
          SizedBox(
            height: 24,
          ),
          BottomWidget(),
        ],
      ),
    );
  }
}
