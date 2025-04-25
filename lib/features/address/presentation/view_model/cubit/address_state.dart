import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/base_state/base_state.dart';

class AddressState extends Equatable {
  BaseState? getInfoFromLatLong;
  BaseState? saveUserAddress;
  BaseState ? loadFile;

  AddressState({this.getInfoFromLatLong, this.saveUserAddress,this.loadFile});

  AddressState copyWith(
      {BaseState? getInfoFromLatLong, BaseState? saveUserAddress, BaseState? loadFile}) {
    return AddressState(
      loadFile: loadFile ?? this.loadFile,
        getInfoFromLatLong: getInfoFromLatLong ?? this.getInfoFromLatLong,
        saveUserAddress: saveUserAddress ?? this.saveUserAddress);
  }

  @override
  List<Object?> get props => [getInfoFromLatLong,saveUserAddress,loadFile];
}

// final class AddressViewModelInitial extends AddressViewModelState {}
