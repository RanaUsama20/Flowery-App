import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/checkout/presentation/widgets/address_card.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';


class DeliveryAddressWidget extends StatefulWidget {
  const DeliveryAddressWidget({super.key});

  @override
  State<DeliveryAddressWidget> createState() => _DeliveryAddressWidgetState();
}

class _DeliveryAddressWidgetState extends State<DeliveryAddressWidget> {
  String? _selectedAddressId;

  final List<Address> _addresses = [
    Address(id: '1', type: 'Home', address: '2XVP+XC - Sheikh Zayed'),
    Address(id: '2', type: 'Office', address: '2XVP+XC - Sheikh Zayed'),
  ];

  void _onSelectAddress(String id) {
    setState(() {
      _selectedAddressId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              LocaleKeys.checkout_Delivery_address.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ..._addresses.map((address) {
              return AddressCard(
                address: address,
                selectedAddressId: _selectedAddressId,
                onSelect: _onSelectAddress,
              );
            }),
            OutlinedButton.icon(
              onPressed: () {
                // Handle add new
              },
              icon: Icon(Icons.add, color: Colors.pink),
              label: Text(
                LocaleKeys.checkout_Add_new.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Address {
  final String id;
  final String type;
  final String address;

  const Address({
    required this.id,
    required this.type,
    required this.address,
  });}