import 'package:flowery_app/features/address/presentation/view/address_screen.dart';
import 'package:flowery_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../profile/domain/entity/profile_data_entity/profile_data_entity.dart';
import '../view_model/cubit/checkout_state.dart';
import 'custom_radio_button.dart';

class AddressCard extends StatelessWidget {
  final AddressEntity address;
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
                    onTap: () => onSelect(address.id!),
                  ),
                  Text(
                    address.city!,
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
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                            builder: (_) => AddressScreen(
                                  addressEntity: address,
                                ))).then((result) {
                        if (result == 'refresh2') {
                        context.read<CheckoutCubit>().doIntent(GetAddressAction());
                        }
                        });
                      },
                      child: SvgPicture.asset(SvgAssets.editSvg)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24,right: 16,bottom: 16),
              child: Row(children: [
                Text(
                  '${address.lat!.length >= 5 ? address.lat?.substring(0, 5) : address.lat}',
                    style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  ' + ',
                    style: Theme.of(context).textTheme.bodySmall
                ),
                Text(
                  '${address.long!.length >= 5 ? address.long?.substring(0, 5) : address.long}',
                    style: Theme.of(context).textTheme.bodySmall
                ),
                Expanded(
                    child: Text(
                      address.street!,
                      style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis),
                    ),

              ]),
            ),
          ],
        ),
      ),
    );
  }
}
