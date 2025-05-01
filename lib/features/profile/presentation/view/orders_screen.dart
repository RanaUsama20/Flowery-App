import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../widget/orders_body.dart';


import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';


class OrdersScreen extends StatelessWidget{
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile_MyOrder.tr()),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),

      ),
      body: OrdersBody() ,
    );


}