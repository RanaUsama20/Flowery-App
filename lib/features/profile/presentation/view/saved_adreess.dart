import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/theme/app_theme.dart';
import 'package:flowery_app/features/profile/presentation/view_model/profile_main/profile_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({super.key, required this.addresses});

  final List<dynamic> addresses;
  @override
  _SavedAddressState createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  late List<dynamic> addresses;
  late ProfileMainCubit cubit;

  @override
  void initState() {
    super.initState();
    addresses = widget.addresses;
    cubit = BlocProvider.of<ProfileMainCubit>(context);

  }

  // Function to delete an address from the list
  void deleteAddress(int index) {
    setState(() {
      addresses.removeAt(index);  // Removes the address at the given index
    });
  }

  // Function to show a confirmation dialog before deleting the address
  Future<void> showDeleteConfirmationDialog(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Address'),
          content: const Text('Are you sure you want to delete this address?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: ()async {
                Navigator.of(context).pop();

                await cubit.deleteAddress(addresses[index]['_id']);

                deleteAddress(index);

              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(

        child: Column(

          children:[

            Row(children: [

              InkWell(

                  onTap: (){ Navigator.pop(context,"refresh");},
                  child: Icon(Icons.arrow_back_ios_new_rounded)),
            ],),



    BlocListener<ProfileMainCubit, ProfileMainState>(
    listener: (context, state) {
    if (state.isDeleteAddressLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Deleting address...')));
    } else if (state.sDeleteAddressSuccess) {
    // Handle success state, e.g., show a success message
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Address deleted successfully')),
    );
    } else if (state.sDeleteAddressFailure) {
    // Handle failure state, e.g., show an error message
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Failed to delete address')),
    );
    }
    },
    child: Expanded(
            child:
            ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];

                // Safely accessing keys using a fallback value if the key doesn't exist
                final String city = address['city'] ?? 'Unknown City';
                final String lat = address['lat'] ?? 'N/A';
                final String long = address['_id'] ?? 'N/A';
                print(address['_id']);
                print("--------------------------------");

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
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                          ],
                        ),
                        SizedBox(height: context.hp(2)),
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
                      ],
                    ),
                  ),
                );
              },
            ),),
          ),]
        ),
      ),
    );
  }
}
