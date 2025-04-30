import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/locale_keys.g.dart';

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
        Lottie.asset('assets/lotties/empty_lottie.json', height: 150, repeat: true),
         Padding(
           padding: const EdgeInsets.all(16.0),
           child: Text(
             'Oops, Looks like you haven’t completed any orders yet.',
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
        Lottie.asset('assets/lotties/error_lottie.json', height: 110, repeat: true),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message ?? 'Oops, something went wrong! Retry?',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        OutlinedButton(
          onPressed: onRetry,
          child: Text(
           'Retry',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16
            ),
          ),
        ),
      ],
    );
  }
}
