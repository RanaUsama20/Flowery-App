import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/dialogs/app_toasts.dart';
import 'package:flowery_app/features/address/data/model/address_request_model.dart';

import 'package:flowery_app/features/address/presentation/view/google_map_screen.dart';
import 'package:flowery_app/features/address/presentation/view_model/cubit/address_cubit.dart';
import 'package:flowery_app/features/address/presentation/view_model/cubit/address_state.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressCubit _addressCubit;

  String? cityName;
  String? areaName;

  @override
  initState() {
    _addressCubit = serviceLocator.get<AddressCubit>()..loadJsonFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(  LocaleKeys.address.tr()),
        ),
        body: BlocBuilder<AddressCubit, AddressState>(
          bloc: _addressCubit,
          builder: (context, state) {
            if (state.loadFiel is BaseLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _addressCubit.latLng = null;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                            value: _addressCubit, child: GoogleMapScreen()),
                      ));
                    },
                    child: Stack(children: [
                      SizedBox(
                        height: 145,
                        width: 343,
                        child: Image.asset(PngAssets.googleMap),
                      ),
                      Positioned(
                        top: 15,
                        right: 130,
                        child: Image.asset(PngAssets.marker),
                      )
                    ]),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: _addressCubit.addressController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          hintText: 'Enter the address',
                          label: Text(LocaleKeys.address.tr()),
                          floatingLabelBehavior: FloatingLabelBehavior.always)),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: _addressCubit.phoneController,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          hintText: 'Enter the phone number',
                          label: Text('Phone number'),
                          floatingLabelBehavior: FloatingLabelBehavior.always)),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: _addressCubit.receptController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          hintText: 'Enter the recipient name',
                          label: Text('Recipient name'),
                          floatingLabelBehavior: FloatingLabelBehavior.always)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: DropdownButtonFormField<Governorate?>(
                            isExpanded: true,
                              decoration: InputDecoration(
                                  label: Text('City'), hintText: 'Cairo'),
                              items: _addressCubit.listOfCity.map((e) {
                                return DropdownMenuItem<Governorate?>(
                                  value: e,
                                  child: Text(e.nameEn),
                                );
                              }).toList(),
                              onChanged: (value) {
                                cityName = value!.nameEn;
                              })),
                      SizedBox(width: 20),
                      Expanded(
                          child: DropdownButtonFormField<Area>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                  label: Text('Area'), hintText: 'October'),
                              items: _addressCubit.listOfArea.map((e) {
                                return DropdownMenuItem<Area>(
                                    value: e,
                                    child: Text(
                                      e.nameEn,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                areaName = value!.nameEn;
                              }))
                    ],
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: double.infinity,
                    child: BlocListener<AddressCubit, AddressState>(
                      bloc: _addressCubit,
                      listener: (context, state) {
                        if(state.saveUserAddress is BaseLoadingState){
                          AppDialogs.showLoadingDialog(context);
                        }
                        else if(state.saveUserAddress is BaseErrorState){
                          Navigator.of(context).pop();
                          final result=state.saveUserAddress as BaseErrorState;
                          AppDialogs.showFailureDialog(context, message: result.toString());
                        }
                        else if(state.saveUserAddress is BaseSuccessState){
                          Navigator.of(context).pop();


                        }
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          _addressCubit.saveAddress(AddressRequestModel(
                              street: _addressCubit.addressController.text,
                              phone: _addressCubit.phoneController.text,
                              city: cityName!,
                              lat: _addressCubit.latLng!.latitude.toString(),
                              long: _addressCubit.latLng!.longitude.toString(),
                              userName: _addressCubit.receptController.text));
                        },
                        style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 15))),
                        child: Text('Save address'),
                      ),
                    ),
                  )
                ],
              ),
            ));
          },
        ));
  }

  // Future<List<Governorate>> loadGovernorates() async {
  //   final String jsonString =
  //       await rootBundle.loadString('assets/city/cities.json');
  //   final List<dynamic> jsonData = json.decode(jsonString);
  //   final Map<String, dynamic>? table = jsonData.firstWhere(
  //     (element) =>
  //         element['type'] == 'table' && element['name'] == 'governorates',
  //     orElse: () => null,
  //   );

  //   if (table == null || table['data'] == null) {
  //     return [];
  //   }

  //   final List<dynamic> data = table['data'];
  //   //print('the table is $data');
  //   listOfCity = data.map((json) => Governorate.fromJson(json)).toList();
  //   return listOfCity;
  // }

  // Future<List<Area>> loadArea() async {
  //   final String jsonString =
  //       await rootBundle.loadString('assets/city/states.json');
  //   final List<dynamic> jsonData = json.decode(jsonString);

  //   final Map<String, dynamic>? table = jsonData.firstWhere(
  //     (element) => element['type'] == 'table' && element['name'] == 'cities',
  //     orElse: () => null,
  //   );

  //   if (table == null || table['data'] == null) {
  //     return [];
  //   }

  //   final List<dynamic> data = table['data'];
  //   listOfArea = data.map((json) => Area.fromJson(json)).toList();
  //   return listOfArea;
  // }
}

// class Governorate {
//   final String id;
//   final String nameAr;
//   final String nameEn;

//   Governorate({
//     required this.id,
//     required this.nameAr,
//     required this.nameEn,
//   });

//   factory Governorate.fromJson(Map<String, dynamic> json) {
//     return Governorate(
//       id: json['id'],
//       nameAr: json['governorate_name_ar'],
//       nameEn: json['governorate_name_en'],
//     );
//   }
// }

// class Area {
//   final String id;
//   final String governorateId;
//   final String nameAr;
//   final String nameEn;

//   Area({
//     required this.id,
//     required this.governorateId,
//     required this.nameAr,
//     required this.nameEn,
//   });

//   factory Area.fromJson(Map<String, dynamic> json) {
//     return Area(
//       id: json['id'],
//       governorateId: json['governorate_id'],
//       nameAr: json['city_name_ar'],
//       nameEn: json['city_name_en'],
//     );
//   }
// }

// Future<List<Area>> loadArea() async {
//   final String jsonString =
//       await rootBundle.loadString('assets/city/states.json');
//   final List<dynamic> jsonData = json.decode(jsonString);

//   final Map<String, dynamic>? table = jsonData.firstWhere(
//     (element) => element['type'] == 'table' && element['name'] == 'cities',
//     orElse: () => null,
//   );

//   if (table == null || table['data'] == null) {
//     return [];
//   }

//   final List<dynamic> data = table['data'];
//   print(data);
//   return data.map((json) => Area.fromJson(json)).toList();
// }
