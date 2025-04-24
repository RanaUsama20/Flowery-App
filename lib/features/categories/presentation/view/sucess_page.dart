import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../core/routes/routes.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LocaleKeys.checkout_title_success.tr()'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LocaleKeys.checkout_description_success.tr()',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.appSection,
                      (route) => false,
                );
              },
              child: Text('LocaleKeys.checkout_back_to_home.tr()'),
            ),
          ],
        ),
      ),
    );
  }
}