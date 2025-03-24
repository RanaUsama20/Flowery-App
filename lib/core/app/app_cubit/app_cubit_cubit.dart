import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/constants/app_values.dart';
import 'package:flowery_app/core/enum/state_user.dart';
import 'package:flowery_app/core/enum/status.dart';
import 'package:flowery_app/core/utils/app_shared_preference.dart';
import 'package:injectable/injectable.dart';

part 'app_cubit_state.dart';

@injectable
class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(const AppCubitState());

  //? Change State User
  void changeStateUser({required String? token}) async {
    emit(state.copyWith(status: Status.loading));
    if (token == null || token.isEmpty) {
      await SharedPreferencesUtils.saveData(
          key: AppValues.stateUser, value: 'guest');
      emit(state.copyWith(stateUser: StateUser.guest, status: Status.success));
    } else {
      await SharedPreferencesUtils.saveData(
          key: AppValues.stateUser, value: 'login');
      emit(state.copyWith(stateUser: StateUser.login, status: Status.success));
    }
  }

  //? get state user
  get getStateUser {
    final stateUser = SharedPreferencesUtils.getData(key: AppValues.stateUser);
    if (stateUser == 'login') {
      return StateUser.login;
    } else {
      return StateUser.guest;
    }
  }
}
