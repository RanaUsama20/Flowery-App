import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/utils/validator.dart';
import 'package:flowery_app/features/address/data/model/address_request_model.dart';

import 'package:flowery_app/features/address/presentation/view/google_map_screen.dart';
import 'package:flowery_app/features/address/presentation/view_model/cubit/address_cubit.dart';
import 'package:flowery_app/features/address/presentation/view_model/cubit/address_state.dart';
import 'package:flowery_app/features/profile/domain/entity/profile_data_entity/profile_data_entity.dart';

import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressScreen extends StatefulWidget {
  AddressEntity? addressEntity;
  AddressScreen({this.addressEntity, super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressCubit _addressCubit;
  String? cityName;
  String? areaName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Governorate? governorate;

  @override
  initState() {
    super.initState();
    _addressCubit = serviceLocator.get<AddressCubit>()..loadJsonFile();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.addressEntity != null) {
      cityName = widget.addressEntity!.city!;
      _addressCubit.phoneController.text = widget.addressEntity!.phone!;
      _addressCubit.receptController.text = widget.addressEntity!.username!;
      _addressCubit.addressController.text = widget.addressEntity!.street!;
      _addressCubit.latLng = LatLng(double.parse(widget.addressEntity!.lat!),
          double.parse(widget.addressEntity!.long!));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.address.tr()),
        ),
        body: BlocConsumer<AddressCubit, AddressState>(
          bloc: _addressCubit,
          listener: (context, state) {
            print(state.saveUserAddress);
            if (state.saveUserAddress is BaseLoadingState) {
              print('Hellloooooooooooooooooooo');
              AppDialogs.showLoadingDialog(context);
            } else if (state.saveUserAddress is BaseErrorState) {
              Navigator.of(context).pop();
              final result = state.saveUserAddress as BaseErrorState;
              AppDialogs.showFailureDialog(context, message: result.toString());
            } else if (state.saveUserAddress is BaseSuccessState) {
              // Navigator.pop(context, 'refresh2');
            }
          },
          builder: (context, state) {
            if (state.loadFiel is BaseLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Builder(builder: (context) {
              if (cityName != null) {
                governorate = _addressCubit.listOfCity.firstWhere((e) {
                  return e.nameEn == cityName!;
                });
              }

              return SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: _formKey,
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
                          validator: (value) {
                            final check = Validator.validateName(value);
                            if (check != null) {
                              return check;
                            }
                            return null;
                          },
                          controller: _addressCubit.addressController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              hintText: 'Enter the address',
                              label: Text(LocaleKeys.address.tr()),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always)),
                      SizedBox(height: 20),
                      TextFormField(
                          validator: (value) {
                            final check = Validator.validatePhoneNumber(value);
                            if (check != null) {
                              return check;
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _addressCubit.phoneController,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              hintText: 'Enter the phone number',
                              label: Text('Phone number'),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always)),
                      SizedBox(height: 20),
                      TextFormField(
                          validator: (value) {
                            final check = Validator.validateName(value);
                            if (check != null) {
                              return check;
                            }
                            return null;
                          },
                          controller: _addressCubit.receptController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              hintText: 'Enter the recipient name',
                              label: Text('Recipient name'),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always)),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: DropdownButtonFormField<Governorate?>(
                                  isExpanded: true,
                                  value: governorate,
                                  decoration: InputDecoration(
                                      label: Text('City'), hintText: 'Cairo'),
                                  items: _addressCubit.listOfCity.map((e) {
                                    return DropdownMenuItem<Governorate?>(
                                      value: e,
                                      child: FittedBox(child: Text(e.nameEn)),
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
                                      label: Text('Area'),
                                      hintText: 'October',
                                      hintStyle: TextStyle(fontSize: 10)),
                                  items: _addressCubit.listOfArea.map((e) {
                                    return DropdownMenuItem<Area>(
                                        value: e,
                                        child: FittedBox(
                                          child: Text(
                                            e.nameEn,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
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
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            if (widget.addressEntity?.id != null) {
                              _addressCubit.editAddress(
                                  widget.addressEntity!.id!,
                                  AddressRequestModel(
                                    street:
                                        _addressCubit.addressController.text,
                                    phone: _addressCubit.phoneController.text,
                                    city: cityName!,
                                    lat: _addressCubit.latLng!.latitude
                                        .toString(),
                                    long: _addressCubit.latLng!.longitude
                                        .toString(),
                                    userName:
                                        _addressCubit.receptController.text,
                                  ));
                              return;
                            }

                            _addressCubit.saveAddress(AddressRequestModel(
                                street: _addressCubit.addressController.text,
                                phone: _addressCubit.phoneController.text,
                                city: cityName!,
                                lat: _addressCubit.latLng!.latitude.toString(),
                                long:
                                    _addressCubit.latLng!.longitude.toString(),
                                userName: _addressCubit.receptController.text));
                            print('ssssswwweeeeeeeeeeeeeee');
                            print(state.saveUserAddress);
                          },
                          style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(vertical: 15))),
                          child: Text('Save address'),
                        ),
                      )
                    ],
                  ),
                ),
              ));
            });
          },
        ));
  }
}
