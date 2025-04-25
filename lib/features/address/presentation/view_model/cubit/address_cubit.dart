import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/address/data/model/address_request_model.dart';
import 'package:flowery_app/features/address/domain/usecase/edit_address_use_case.dart';
import 'package:flowery_app/features/address/domain/usecase/save_address_use_case.dart';
import 'package:flowery_app/features/address/presentation/view_model/cubit/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

@injectable
class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this._saveAddressUseCase, this._editAddressUseCase)
      : super(AddressState());
  final SaveAddressUseCase _saveAddressUseCase;
  final EditAddressUseCase _editAddressUseCase;

  saveAddress(AddressRequestModel addressRequest) async {
    emit(state.copyWith(saveUserAddress: BaseLoadingState()));
    final ans = await _saveAddressUseCase(addressRequest);
    switch (ans) {
      case SuccessResult<String>():
        emit(state.copyWith(saveUserAddress: BaseSuccessState(data: ans)));

      case FailureResult():
        emit(state.copyWith(
            saveUserAddress: BaseErrorState(errorMessage: ans.toString())));
    }
  }

  editAddress(String id, AddressRequestModel addressRequest) async {
    emit(state.copyWith(saveUserAddress: BaseLoadingState()));
    final ans = await _editAddressUseCase(id, addressRequest);
    switch (ans) {
      case SuccessResult<String>():
        emit(state.copyWith(saveUserAddress: BaseSuccessState(data: ans)));

      case FailureResult():
        emit(state.copyWith(
            saveUserAddress: BaseErrorState(errorMessage: ans.toString())));
    }
  }

  getInfoLatLong({required double latitude, required double longitude}) async {
    try {
      emit(state.copyWith(getInfoFromLatLong: BaseLoadingState()));
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      print(
          'locality: ${placemarks[1].subAdministrativeArea}  street: ${placemarks[1].street} addminArea ${placemarks[1].administrativeArea}  code: ${placemarks[1].subLocality}');

      if (placemarks[1].subAdministrativeArea != null) {
        areaController.text = placemarks[1].subAdministrativeArea!;
      }
      if (placemarks[1].street != null) {
        addressController.text = placemarks[1].street!;
      }
      if (placemarks[1].administrativeArea != null) {
        cityController.text = placemarks[1].administrativeArea!.split(' ')[0];
      }
      latLng = LatLng(latitude, longitude);
      emit(state.copyWith(getInfoFromLatLong: BaseSuccessState()));
    } catch (e) {
      emit(state.copyWith(
          getInfoFromLatLong:
              BaseErrorState(errorMessage: 'Failed get location Try again')));
    }
  }

  loadJsonFile() async {
    emit(state.copyWith(getInfoFromLatLong: BaseLoadingState()));
    listOfArea = await loadArea();
    listOfCity = await loadGovernorates();
    
    emit(state.copyWith(getInfoFromLatLong: BaseSuccessState()));
  }

  Future<List<Governorate>> loadGovernorates() async {
    final String jsonString =
        await rootBundle.loadString('assets/city/cities.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    final Map<String, dynamic>? table = jsonData.firstWhere(
      (element) =>
          element['type'] == 'table' && element['name'] == 'governorates',
      orElse: () => null,
    );

    if (table == null || table['data'] == null) {
      return [];
    }

    final List<dynamic> data = table['data'];

    listOfCity = data.map((json) => Governorate.fromJson(json)).toList();

    return listOfCity;
  }

  Future<List<Area>> loadArea() async {
    final String jsonString =
        await rootBundle.loadString('assets/city/states.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    final Map<String, dynamic>? table = jsonData.firstWhere(
      (element) => element['type'] == 'table' && element['name'] == 'cities',
      orElse: () => null,
    );

    if (table == null || table['data'] == null) {
      return [];
    }

    final List<dynamic> data = table['data'];
    listOfArea = data.map((json) => Area.fromJson(json)).toList();
    return listOfArea;
  }

  List<Area> listOfArea = [];
  List<Governorate> listOfCity = [];
  LatLng? latLng;
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController receptController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
}

class Governorate {
  final String id;
  final String nameAr;
  final String nameEn;

  Governorate({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: json['id'],
      nameAr: json['governorate_name_ar'],
      nameEn: json['governorate_name_en'],
    );
  }
}

class Area {
  final String id;
  final String governorateId;
  final String nameAr;
  final String nameEn;

  Area({
    required this.id,
    required this.governorateId,
    required this.nameAr,
    required this.nameEn,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      governorateId: json['governorate_id'],
      nameAr: json['city_name_ar'],
      nameEn: json['city_name_en'],
    );
  }
}
