import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import 'custom_radio_button.dart';
import 'delivery_address_widget.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final String? selectedAddressId;
  final ValueChanged<String> onSelect;

  const AddressCard({
    super.key,
    required this.address,
    required this.selectedAddressId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.white,
        elevation: 1,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomRadioButton(
                    selected: selectedAddressId == address.id,
                    onTap: () => onSelect(address.id),
                  ),
                  Text(
                    address.type,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(SvgAssets.editSvg),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 24, right: 32, bottom: 16),
                  child: Text(
                    address.address,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}
