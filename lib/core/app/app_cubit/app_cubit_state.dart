part of 'app_cubit_cubit.dart';

class AppCubitState extends Equatable {
  final Status status;
  final StateUser stateUser;
  final Status location;
  final Placemark locationAddress;
  const AppCubitState({
    this.status = Status.initial,
    this.stateUser = StateUser.guest,
    this.location = Status.initial,
    this.locationAddress = const Placemark(),
  });
  //? copyWith
  AppCubitState copyWith({
    Status? status,
    StateUser? stateUser,
    Status? location,
    Placemark? locationAddress,
  }) {
    return AppCubitState(
      status: status ?? this.status,
      stateUser: stateUser ?? this.stateUser,
      location: location ?? this.location,
      locationAddress: locationAddress ?? this.locationAddress,
    );
  }

  @override
  List<Object> get props => [status, stateUser, location, locationAddress];
}
