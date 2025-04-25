import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/locale_keys.g.dart';
import '../view_model/cubit/checkout_cubit.dart';

class BottomWidget extends StatelessWidget {
  final num price;
  CheckoutCubit checkoutCubit;
  static const int deliveryFee = 100;

   BottomWidget({super.key,required this.price,required this.checkoutCubit});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.checkout_Sub_Total.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16),
                ),
                Text(
                  '${price.toString()}\$',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.checkout_Delivery_Fee.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16),
                ),
                Text(
                  " $deliveryFee\$",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16),
                ),
              ],
            ),
            Divider(
              color: AppColors.black[AppColors.colorCode40],
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.checkout_Total.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${(price + deliveryFee).toString()}\$',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {

                    final cubit = context.read<CheckoutCubit>();
                    cubit.placeOrder(
                    );
                  },
                  child: Text(
                    LocaleKeys.checkout_Place_order.tr(),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
