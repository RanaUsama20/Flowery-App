import 'package:flowery_app/features/auth/data/model/request/verify_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:injectable/injectable.dart';
import '../../../data/api/auth_retrofit_client.dart';
import '../../../data/model/request/forgot_password_request.dart';
import '../../../data/model/request/reset_password_request.dart';
import '../../../domain/usecase/auth_use_case.dart';
import 'forgot_password_state.dart'; // Import the states we defined
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthUseCase useCase;
  ForgotPasswordCubit(this.useCase) : super(ForgotPasswordInitialState());

  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  // Method to remove email (optional)
  Future<void> removeEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }
  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    emit(ForgotPasswordLoadingState());
    // Check if the email is null and pass the email accordingly

 final  result = await useCase.forgotPassword(request); // If email is null, use request as is

    // Handle success and failure results
    switch (result) {
      case SuccessResult<Map<String, dynamic>>():
        emit(ForgotPasswordSuccessState(result.data['message']));
        await saveEmail(request.email);  // Save the email after success
        break; // Add break here to prevent falling through to the failure case
      case FailureResult<Map<String, dynamic>>():
        emit(ForgotPasswordFailureState(result.exception.toString()));
        break; // Add break here to prevent falling through
    }

    emit(ForgotPasswordInitialState());
  }

  Future<void> resendCode() async {
    emit(ForgotPasswordLoadingState());
    String? email = await getEmail();
    // Check if the email is null and pass the email accordingly


      // If email is not null, update the request email and pass it
   final   result = await useCase.forgotPassword(ForgotPasswordRequest(email: email!));


    // Handle success and failure results
    switch (result) {
      case SuccessResult<Map<String, dynamic>>():
        emit(ForgotPasswordSuccessResendState(result.data['message']));
        await saveEmail(email);  // Save the email after success
        break; // Add break here to prevent falling through to the failure case
      case FailureResult<Map<String, dynamic>>():
        emit(ForgotPasswordFailureState(result.exception.toString()));
        break; // Add break here to prevent falling through
    }

    emit(ForgotPasswordInitialState());
  }


  Future<void> sendResetCode({ required String code}) async {
    emit(ForgotPasswordLoadingState());
    final result = await useCase.verifyResetCode(VerifyResetCodeRequest(resetCode: code, ));
    switch (result) {
      case SuccessResult<Map<String,dynamic>>():
        {
          Future.delayed(Duration(seconds: 1), () {
            emit(ForgotPasswordSuccessState(result.data['status']));
          });
        }
      case FailureResult<Map<String,dynamic>>():
        {Future.delayed(Duration(seconds: 1), () {
          emit(ForgotPasswordFailureState(result.exception.toString()));

        });
        }
    }
  }

  Future<void> verifyResetPassword({ required String newPassword,required String confirmPassword}) async {
    emit(ForgotPasswordLoadingState());
    String? email = await getEmail();

    print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]");
    print(email);
    final result = await useCase.resetPassword(ResetPasswordRequest(email: email!, newPassword: newPassword) );
    switch (result) {
      case SuccessResult<Map<String,dynamic>>():
        {
          Future.delayed(Duration(seconds: 1), () {
            emit(ForgotPasswordSuccessState(result.data['message']));
          });
        }
      case FailureResult<Map<String,dynamic>>():
        {Future.delayed(Duration(seconds: 1), () {
          emit(ForgotPasswordFailureState(result.exception.toString()));

        });
        }
    }
  }
}
