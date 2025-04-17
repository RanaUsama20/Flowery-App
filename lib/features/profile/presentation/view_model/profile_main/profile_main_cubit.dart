import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/enum/status.dart';
import 'package:flowery_app/core/utils/save_local.dart';
import 'package:flowery_app/features/auth/domain/usecase/logout_use_case.dart';
import 'package:flowery_app/features/profile/domain/usecase/get_profile_data_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/app/app_cubit/app_cubit_cubit.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../domain/entity/profile_data_entity/profile_data_entity.dart';

part 'profile_main_state.dart';

@injectable
class ProfileMainCubit extends Cubit<ProfileMainState> {
  GetProfileDataUseCase _getProfileDataUseCase;
  LogoutUseCase _logoutUseCase;
  AppCubit appCubit;
  ProfileMainCubit(this._getProfileDataUseCase,this._logoutUseCase,this.appCubit) : super(const ProfileMainState());
  Future<void> getProfileData() async {
    emit(state.copyWith(profileMainStatus: Status.loading));
    final result = await _getProfileDataUseCase.call();
    switch (result) {
      case SuccessResult<ProfileDataEntity>():
        emit(state.copyWith(
          profileMainStatus: Status.success,
          profileData: result.data,
        ));
      case FailureResult<ProfileDataEntity>():
        emit(state.copyWith(
          profileMainStatus: Status.failure,
          errorMessage: result.exception.toString(),
        ));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(logoutStatus: Status.loading));
    final result = await _logoutUseCase.call();
    switch (result) {
      case SuccessResult<String>():
        emit(state.copyWith(
            logoutStatus: Status.success,
          logOutMessageResponse: result.data
        ));
        SaveLocal.removeData(key: 'token');
        appCubit.changeStateUser(token: null);
      case FailureResult<String>():
        emit(state.copyWith(
            logoutStatus: Status.failure,
            logOutMessageResponse: result.exception.toString()

        ));


  }
}}
