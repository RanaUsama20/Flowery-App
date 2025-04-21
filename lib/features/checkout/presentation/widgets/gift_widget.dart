import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/utils/validator.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../profile/presentation/widget/custom_witch.dart';

class GiftWidget extends StatefulWidget {
  const GiftWidget({super.key});

  @override
  State<GiftWidget> createState() => _GiftWidgetState();
}

class _GiftWidgetState extends State<GiftWidget> {
  bool isOn = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: AppColors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CustomSwitch(
                  width: 44,
                  height: 26,
                  value: isOn,
                  onChanged: (value) {
                    setState(() {
                      isOn = value;
                    });
                  },
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  LocaleKeys.checkout_It_is_a_gift.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (val) => Validator.validateName(val),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.checkout_Name.tr(),
                      hintText: LocaleKeys.checkout_Enter_the_name.tr(),
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: phoneNumberController,
                    validator: (val) => Validator.validatePhoneNumber(val),
                    decoration: InputDecoration(
                      labelText: LocaleKeys.checkout_Phone_number.tr(),
                      hintText: LocaleKeys.checkout_Enter_the_phone.tr(),
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
