import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/profile/presentation/widget/order_card.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/error_widget.dart';
import '../../domain/entity/orders/orders_entity.dart';

class BuildOrdersList extends StatelessWidget {
  List<OrdersEntity>? orders;
  bool flag;
  BuildOrdersList({required this.orders, required this.flag});
  @override
  Widget build(BuildContext context) {
    if (orders!.isEmpty) {
      return EmptyStateWidget();
    }
    return ListView.builder(
      itemCount: orders!.length,
      itemBuilder: (context, index) {
        final order = orders![index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...?order.orderItems?.map((item) {
              final product = item.product;
              return OrderCard(
                title: product?.title,
                price: order.totalPrice.toString() ?? '',
                state: flag
                    ? '${LocaleKeys.profile_order_number.tr()} ${order.orderNumber}'
                    : LocaleKeys.profile_Delivered_on.tr(),
                buttonText: flag
                    ? LocaleKeys.profile_Track_order.tr()
                    : LocaleKeys.profile_Reorder.tr(),
                imageUrl: product?.imgCover,
              );
            }).toList(),
          ],
        );
      },
    );

    // return ListView.builder(
    //   itemCount: orders!.length,
    //   itemBuilder: (context, index) {
    //     final order = orders![index];
    //     return OrderCard(
    //         title: order.orderItems?[0].product?.title,
    //         price: order.totalPrice.toString(),
    //         state: flag
    //             ? '${LocaleKeys.profile_order_number.tr()} ${order.orderNumber}'
    //             : LocaleKeys.profile_Delivered_on.tr(),
    //         buttonText: flag
    //             ? LocaleKeys.profile_Track_order.tr()
    //             : LocaleKeys.profile_Reorder.tr(),
    //         imageUrl: order.orderItems?[0].product?.imgCover);
    //   },
    // );
  }
}
