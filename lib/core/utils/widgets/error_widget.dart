import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/locale_keys.g.dart';
import '../../constants/app_assets.dart';

class EmptyStateWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final VoidCallback? onRetry;

  const EmptyStateWidget({this.height, this.width, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(AppLottie.emptyLottie, height: 150, repeat: true),
         Padding(
           padding: const EdgeInsets.all(16.0),
           child: Text(
             LocaleKeys.profile_no_orders.tr(),
            style: Theme.of(context).textTheme.bodySmall,
                   ),
         ),

      ],
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? message;
  final VoidCallback? onRetry;

  const ErrorStateWidget({this.height, this.width, this.onRetry, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(AppLottie.errorLottie, height: 110, repeat: true),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message ?? LocaleKeys.Error_general_error.tr(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        OutlinedButton(
          onPressed: onRetry,
          child: Text(
            LocaleKeys.Retry.tr(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16
            ),
          ),
        ),
      ],
    );
  }
}
