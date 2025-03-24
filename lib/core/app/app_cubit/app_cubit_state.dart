part of 'app_cubit_cubit.dart';

class AppCubitState extends Equatable {
  final Status status;
  final StateUser stateUser;
  const AppCubitState({
    this.status = Status.initial,
    this.stateUser = StateUser.guest,
  });
  //? copyWith
  AppCubitState copyWith({
    Status? status,
    StateUser? stateUser,
  }) {
    return AppCubitState(
      status: status ?? this.status,
      stateUser: stateUser ?? this.stateUser,
    );
  }

  @override
  List<Object> get props => [status, stateUser];
}
