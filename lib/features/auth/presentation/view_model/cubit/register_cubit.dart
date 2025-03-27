import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';
import 'package:flowery_app/features/auth/domain/usecase/register_use_case.dart';
import 'package:flowery_app/features/auth/presentation/view_model/cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(RegisterState());

  final RegisterUseCase _registerUseCase;
  String gender = 'female';
  register(RegisterRequestModel registerRequest) async {
    emit(state.copyWith(registerState: BaseLoadingState()));
    Result<String> ans = await _registerUseCase(registerRequest);
    switch (ans) {
      case SuccessResult<String>():
        {
          emit(state.copyWith(
              registerState: BaseSuccessState<String>(data: ans.data)));
        }
      case FailureResult<String>():
        {
          emit(state.copyWith(
              registerState:
                  BaseErrorState(errorMessage: ans.exception.toString())));
        }
    }
  }
}
