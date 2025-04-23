import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/dialogs/loading_widget.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';

class AppDialogs {
  // Show a loading dialog
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: LoadingWidget(),
          ),
        );
      },
    );
  }

  // Show a success dialog
  static void showSuccessDialog(
    BuildContext context, {
    required String message,
    String? buttonText,
    String? nextActionTitle,
    VoidCallback? nextAction,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(message),
            ],
          ),
          actions: [
            if (nextActionTitle != null)
              TextButton(
                onPressed: nextAction,
                child: Text(nextActionTitle),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(buttonText ?? LocaleKeys.Ok),
            ),
          ],
        );
      },
    );
  }

  // Show a failure dialog
  static void showFailureDialog(
    BuildContext context, {
    required String message,
    String? buttonText,
    VoidCallback? nextAction,
    String? nextActionTitle,
    String? title,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? LocaleKeys.Error),
          content: Text(message),
          actions: [
            if (nextAction != null && nextActionTitle != null)
              TextButton(
                onPressed: nextAction,
                child: Text(nextActionTitle),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                buttonText ?? LocaleKeys.Ok,
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showLoginDialog(
    BuildContext context, {
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.appSection);
                },
                child: Text(LocaleKeys.cancel.tr())),
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed(Routes.login),
              child: Text(LocaleKeys.Ok.tr()),
            ),
          ],
        );
      },
    );
  }
}
