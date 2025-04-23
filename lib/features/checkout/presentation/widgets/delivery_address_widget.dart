import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flowery_app/features/checkout/presentation/widgets/address_card.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_state/base_state.dart';
import '../../../../core/dialogs/app_dialogs.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../profile/domain/entity/profile_data_entity/profile_data_entity.dart';
import '../view_model/cubit/checkout_state.dart';


class DeliveryAddressWidget extends StatefulWidget {
  const DeliveryAddressWidget({super.key,required this.checkoutCubit,required this.onAddressSelected});
 final  CheckoutCubit checkoutCubit;
  final Function(String) onAddressSelected;


  @override
  State<DeliveryAddressWidget> createState() => _DeliveryAddressWidgetState();
}

class _DeliveryAddressWidgetState extends State<DeliveryAddressWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  String? _selectedAddressId;


  void _onSelectAddress(String id) {
    setState(() {
      _selectedAddressId = id;
    });
    widget.onAddressSelected(id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit,CheckoutStates>(
      builder: (context, state) {
        if (state.profileState is BaseLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.profileState is BaseHideLoadingState) {
          Navigator.of(context).pop();
        }
        if (state.profileState is BaseErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppDialogs.showFailureDialog(
              context,
              message: (state.profileState as BaseErrorState).errorMessage,
            );
          });
        }
        if (state.profileState is BaseSuccessState) {
          final profileData = (state.profileState as BaseSuccessState).data as SuccessResult<ProfileDataEntity>;
           final addressList = profileData.data.user.addresses;
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
                  ...addressList.map((address) {
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
        return const Placeholder();
      }
    );
  }
}
