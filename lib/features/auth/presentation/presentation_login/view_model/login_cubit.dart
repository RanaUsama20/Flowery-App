import 'package:flowery_app/features/auth/domain/usecase/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/error/failuer.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  // void login({required String email, required String password}) async {
  //   emit(LoginLoadingState());
  //
  //   if (email.isEmpty || password.isEmpty) {
  //     emit(LoginErrorState(ValidationFailure('Please enter both email and password')));
  //     return;
  //   }
  //
  //   if (Validator.validateEmail(email) != null) {
  //     emit(LoginErrorState(ValidationFailure('Please enter a valid email address')));
  //     return;
  //   }
  //
  //   try {
  //     final loginEntity = await loginUseCase.call(email: email, password: password);
  //     emit(LoginSuccessState(loginEntity: loginEntity!,message: 'Login successful'));
  //   } catch (e) {
  //     emit(LoginErrorState(ServerFailure('Login failed: ${e.toString()}')));
  //   }
  // }


  void login({required String email, required String password}) async {
    emit(LoginLoadingState());

    if (email.isEmpty || password.isEmpty) {
      emit(LoginErrorState(ServerFailure("Please enter both email and password")));
      return;
    }

    try {
      final loginEntity = await loginUseCase.call(email: email, password: password);

      if (loginEntity == null) {
        emit(LoginErrorState(ServerFailure("Incorrect email or password")));
      } else {
        emit(LoginSuccessState(loginEntity: loginEntity));
      }
    } catch (e) {
      emit(LoginErrorState(ServerFailure("Login failed: ${e.toString()}")));
    }
  }


}



