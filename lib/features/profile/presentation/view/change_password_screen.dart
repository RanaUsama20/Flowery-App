import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../widget/change_password_body.dart';

class ChangePasswordScreen extends StatelessWidget{
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Profile_ResetPassword.tr()),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),

      ),
      body: ChangePasswordBody() ,
    );
  }

}