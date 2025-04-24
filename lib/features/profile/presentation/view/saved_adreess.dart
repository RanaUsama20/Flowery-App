import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/theme/app_theme.dart';
import 'package:flowery_app/features/profile/presentation/view_model/profile_main/profile_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/model/address_model.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({super.key});

  @override
  _SavedAddressState createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  late List<dynamic> addresses;
  late ProfileMainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit =  context.read<ProfileMainCubit>();
    addresses = List.from(cubit.state.profileData.user.addresses);
  }


  Future<void> deleteAddress(int index) async {
    await cubit.deleteAddress(addresses[index]['_id']);
    setState(() {
      addresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileMainCubit, ProfileMainState>(
      listener: (context, state) {

        if (state.isDeleteAddressLoading) {
          ScaffoldMessenger.of(context).showSnackBar(

             SnackBar(
                backgroundColor:AppColors.pink,
                content: Text( LocaleKeys.Profile_Deleting_address)),
          );
          
        } else if (state.isDeleteAddressSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                 backgroundColor:AppColors.pink,
                 content: Text(
                     LocaleKeys.Profile_Address_deleted_successfully)),
          );
        } else if (state.isDeleteAddressFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                 backgroundColor:AppColors.pink,
                 content: Text(LocaleKeys.Profile_Failed_to_delete_address.tr())),
          );
        }
      },
      child:
      Scaffold(

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical:20 ),
          child: Column(

            children:[

              Row(children: [

                InkWell(

                    onTap: (){ Navigator.pop(context,"refresh");},
                    child: Icon(Icons.arrow_back_ios_new_rounded ,)),

                Text(LocaleKeys.Profile_Saved_address.tr(),style: AppTheme.lightTheme.textTheme.titleLarge,),
              ],),


              SizedBox(height: context.hp(3)),



           Expanded(
              child:
              ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];

                  // Safely accessing keys using a fallback value if the key doesn't exist
                  final String city = address['city'] ??  LocaleKeys.Profile_Unknown_City.tr();
                  final String lat = address['lat'] ?? 'N/A';
                  final String long = address['long'] ?? 'N/A';


                  return Card(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: AppColors.white[AppColors.colorCode70]!,
                        width: 0.2,
                      ),
                    ),
                    shadowColor: AppColors.white,
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: context.sp(20),
                              ),
                              Text(
                                city,
                                style: AppTheme.lightTheme.textTheme.titleSmall,
                              ),
                              Spacer(),
                              // Delete button (Trash icon)
                              IconButton(
                                icon: Icon(Icons.delete, color: AppColors.pink),
                                onPressed: () => showDeleteConfirmationDialog(index), // Show confirmation dialog
                              ),
                              IconButton(
                                icon: Icon(Icons.edit_outlined, color: AppColors.gray),
                                  onPressed: () {
                                    // final addressModel = AddressModel.fromMap(addresses[index]);
                                    //
                                    // Navigator.pushNamed(
                                    //   context,
                                    //  // Routes.editAddress,
                                    //   arguments: addressModel,
                                    // ).then((result) {
                                    //   if (result == 'refresh_again') {
                                    //     cubit.getProfileData();
                                    //   }
                                    // });
                                  }
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                lat,
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                              ),
                              Text(
                                ' + ',
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                              ),
                              Text(
                                long,
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                              ),
                              Text(
                                ' - ',
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                              ),
                              Text(
                                city,
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                              ),
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
                padding:  EdgeInsets.only(bottom: context.hp(37),top: context.hp(6)),
                child: InkWell(
                  onTap: () {

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
                        style: AppTheme.lightTheme.textTheme.labelLarge!
                            .copyWith(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),),
    );
  }

  Future<void> showDeleteConfirmationDialog(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text(LocaleKeys.Profile_Delete_Address.tr()),
          content:  Text(LocaleKeys.Profile_already_want_delete.tr()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child:  Text(LocaleKeys.Profile_cancel.tr()),
            ),
            TextButton(
              onPressed: ()async {
                Navigator.of(context).pop();


                deleteAddress(index);

              },
              child:  Text(LocaleKeys.Profile_delete.tr()),
            ),
          ],
        );
      },
    );
  }

}
