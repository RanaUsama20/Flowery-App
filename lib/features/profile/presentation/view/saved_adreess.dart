import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/theme/app_theme.dart';
import 'package:flowery_app/features/address/presentation/view/address_screen.dart';
import 'package:flowery_app/features/profile/presentation/view_model/profile_main/profile_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/locale_keys.g.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({super.key});

  @override
  State<SavedAddress> createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  late ProfileMainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileMainCubit>();
  }

  Future<void> deleteAddress(String id) async {
    await cubit.deleteAddress(id);
    await cubit.getProfileData(); // Refresh after deletion
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileMainCubit, ProfileMainState>(
      listener: (context, state) {
        if (state.isDeleteAddressLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.pink,
              content: Text(LocaleKeys.Profile_Deleting_address.tr()),
            ),
          );
        } else if (state.isDeleteAddressSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.pink,
              content: Text(LocaleKeys.Profile_Address_deleted_successfully.tr()),
            ),
          );
        } else if (state.isDeleteAddressFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.pink,
              content: Text(LocaleKeys.Profile_Failed_to_delete_address.tr()),
            ),
          );
        }
      },
      builder: (context, state) {
        final addresses = state.profileData.user.addresses;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context, "refresh"),
                        child: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        LocaleKeys.Profile_Saved_address.tr(),
                        style: AppTheme.lightTheme.textTheme.titleLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: context.hp(3)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final address = addresses[index];

                        final String city = address.city ?? LocaleKeys.Profile_Unknown_City.tr();
                        final String lat = address.lat ?? 'N/A';
                        final String long = address.long ?? 'N/A';

                        return Card(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: AppColors.white[AppColors.colorCode70]!,
                              width: 0.2,
                            ),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined, size: context.sp(20)),
                                    Text(
                                      city,
                                      style: AppTheme.lightTheme.textTheme.titleSmall,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: AppColors.pink),
                                      onPressed: () => _showDeleteDialog(address.id ?? ''),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit_outlined, color: AppColors.gray),
                                      onPressed: () {
                                        // Navigate to edit address screen
                                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddressScreen(addressEntity: address)));
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(lat),
                                    const Text(' + '),
                                    Text(long),
                                    const Text(' - '),
                                    Text(city),
                                  ],
                                ),
                                SizedBox(height: context.hp(2)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: context.hp(4), top: context.hp(6)),
                    child: InkWell(
                      onTap: () {

                        Navigator.of(context).pushNamed(Routes.address);
                      },
                      child: Container(
                        width: context.wp(90),
                        height: context.hp(8),
                        decoration: BoxDecoration(
                          color: AppColors.pink,
                          borderRadius: BorderRadius.circular(context.sp(40)),
                        ),
                        child: Center(
                          child: Text(
                            LocaleKeys.Profile_Add_new_address.tr(),
                            style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(
                              fontSize: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(LocaleKeys.Profile_Delete_Address.tr()),
        content: Text(LocaleKeys.Profile_already_want_delete.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(LocaleKeys.Profile_cancel.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteAddress(id);
            },
            child: Text(LocaleKeys.Profile_delete.tr()),
          ),
        ],
      ),
    );
  }
}
