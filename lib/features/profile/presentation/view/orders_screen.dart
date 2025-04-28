import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget{
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: Text(LocaleKeys.profile_MyOrder.tr()),

     ),
   );
  }

}