import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/base_state/base_state.dart';

class AddressState extends Equatable {
  BaseState? getInfoFromLatLong;
  BaseState? saveUserAddress;
  BaseState ? loadFiel;

  AddressState({this.getInfoFromLatLong, this.saveUserAddress,this.loadFiel});
  AddressState copyWith(
      {BaseState? getInfoFromLatLong, BaseState? saveUserAddress, BaseState? loadFile}) {
    return AddressState(
      loadFiel: loadFile ?? this.loadFiel,
        getInfoFromLatLong: getInfoFromLatLong ?? this.getInfoFromLatLong,
        saveUserAddress: saveUserAddress ?? this.saveUserAddress);
  }

  @override
  List<Object?> get props => [getInfoFromLatLong];
}

// final class AddressViewModelInitial extends AddressViewModelState {}
