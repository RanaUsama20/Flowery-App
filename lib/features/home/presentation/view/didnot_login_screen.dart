import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/widgets/error_widget.dart';

class DidnotLoginScreen extends StatelessWidget {
  const DidnotLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: ErrorStateWidget(
        height: context.hp(70),
        width: 400,
          message: "please log in to use this future ",
            functionMessage: "log in",
            lottie: AppLottie.loginLottie,
            onRetry: () => Navigator.of(context).pushNamed(Routes.login),
            ),
    ),


    );
  }
}
