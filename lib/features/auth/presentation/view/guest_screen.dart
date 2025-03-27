import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              Image.asset(
                ImageAssets.helloUser,
                width: context.wp(100),
                height: context.hp(50),
                fit: BoxFit.cover,
              ),
              SizedBox(height: context.hp(1)),
              _elevateButton(
                onPressed: () {
                  //? Navigator push to home screen
                },
                title: LocaleKeys.Authentication_ContinueAsGuest.tr(),
                isBordered: true,
              ),
              SizedBox(height: context.hp(2)),
              _elevateButton(
                onPressed: () {
                  //? Navigator push to Login screen
                },
                title: LocaleKeys.Authentication_Login.tr(),
                isBordered: false,
              ),
              SizedBox(height: context.hp(2)),
              _elevateButton(
                onPressed: () {
                  //? Navigator push to register screen
                },
                title: LocaleKeys.Authentication_SignUp.tr(),
                isBordered: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _elevateButton({
    required void Function()? onPressed,
    required String title,
    required bool isBordered,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: isBordered
            ? BorderSide(
                color: AppColors.black,
              )
            : null,
        backgroundColor: isBordered ? Colors.transparent : null,
        minimumSize: Size(
          context.wp(100),
          context.hp(5),
        ),
      ),
      child: Text(
        title,
        style: isBordered ? Theme.of(context).textTheme.titleSmall : null,
      ),
    );
  }
}
