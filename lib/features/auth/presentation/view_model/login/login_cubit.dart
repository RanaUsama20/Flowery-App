import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart';
import 'package:flowery_app/core/utils/save_local.dart';
import 'package:flowery_app/features/auth/domain/usecase/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/error/failuer.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../domain/entity/login_entity.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());

    if (email.isEmpty || password.isEmpty) {
      emit(LoginErrorState(
        ValidationFailure("${LocaleKeys.Error_PleaseEnterBoEmailAndPassword.tr()} "),
      ));
      return;
    }

    try {
      final result = await loginUseCase.call(email: email, password: password);

      switch (result) {
        case SuccessResult<LoginEntity?>():
          final data = result.data;
          if (data == null) {
            emit(LoginErrorState(ServerFailure(
                "${LocaleKeys.Error_PleaseEnterBoEmailAndPassword.tr()} ")));
            return;
          }

          final token = await SaveLocal.getString("token");
          // AppCubit().changeStateUser(token: token);
          emit(LoginSuccessState(loginEntity: data));

        case FailureResult<LoginEntity?>():
          final failure = _extractFailure(result.exception);
          emit(LoginErrorState(failure));
      }
    } catch (e) {
      emit(LoginErrorState(ServerFailure(e.toString())));
    }
  }

  Failure _extractFailure(Object exception) {
    if (exception is Failure) {
      return exception;
    }
    return ServerFailure(exception.toString());
  }
}
