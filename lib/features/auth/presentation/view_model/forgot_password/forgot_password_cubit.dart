import 'dart:developer';

import 'package:flowery_app/core/enum/status.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/domain/entity/forgot_password_response_entity.dart';
import 'package:flowery_app/features/auth/domain/usecase/forgot_password_use_case.dart';
import 'package:flowery_app/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/verify_reset_code_use_case.dart';
import 'forgot_password_state.dart'; // Import the states we defined

@injectable
class ForgotPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  ForgotPasswordCubit(
    this._forgotPasswordUseCase,
    this._verifyResetCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgetPasswordState());

  Future<void> forgotPassword(String email) async {
    emit(state.copyWith(forgotPasswordStatus: Status.loading));
    final result = await _forgotPasswordUseCase.call(email: email);
    switch (result) {
      case SuccessResult<ForgotPasswordResponseEntity>():
        emit(state.copyWith(forgotPasswordStatus: Status.success, email: email));
      case FailureResult<ForgotPasswordResponseEntity>():
        emit(state.copyWith(
            forgotPasswordStatus: Status.failure,
            errorMessage: result.exception.toString()));
    }
  }

  Future<void> verifyResetCode(String code) async {
    emit(state.copyWith(verifyResetCodeStatus: Status.loading));
    final result = await _verifyResetCodeUseCase.call(code: code);
    switch (result) {
      case SuccessResult<ForgotPasswordResponseEntity>():
        emit(state.copyWith(verifyResetCodeStatus: Status.success));
      case FailureResult<ForgotPasswordResponseEntity>():
        emit(state.copyWith(
            verifyResetCodeStatus: Status.failure,
            errorMessage: result.exception.toString()));
    }
  }

  Future<void> resetPassword(String newPassword) async {
    print(newPassword);
    print("-------------------------------");
    emit(state.copyWith(resPasswordStatus: Status.loading));
    log(state.email.toString());
    final result =
        await _resetPasswordUseCase.call(newPassword: newPassword, email: state.email);
    switch (result) {
      case SuccessResult<ForgotPasswordResponseEntity>():
        emit(state.copyWith(resPasswordStatus: Status.success));
      case FailureResult<ForgotPasswordResponseEntity>():
        emit(state.copyWith(
            resPasswordStatus: Status.failure,
            errorMessage: result.exception.toString()));
    }
  }

  // Future<void> saveEmail(String email) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('email', email);
  // }

  // Future<String?> getEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('email');
  // }

  // // Method to remove email (optional)
  // Future<void> removeEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('email');
  // }

  // bool _isValidEmail(String email) {
  //   // A simple regex pattern to check if the email is valid
  //   final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  //   return regex.hasMatch(email);
  // }

  // Future<void> forgotPassword(ForgotPasswordRequestDto request) async {
  //   // Check if email is empty or invalid
  //   if (request.email.isEmpty) {
  //     emit(ForgotPasswordFailureState("Email cannot be empty"));
  //     return;
  //   }
  //   if (!_isValidEmail(request.email)) {
  //     emit(ForgotPasswordFailureState("Please enter a valid email"));
  //     return;
  //   }

  //   emit(ForgotPasswordLoadingState());
  //   final result = await useCase.forgotPassword(request);

  //   // Handle success and failure results
  //   if (result is SuccessResult<Map<String, dynamic>>) {
  //     emit(ForgotPasswordSuccessState(result.data['message']));
  //     await saveEmail(request.email); // Save the email after success
  //   } else if (result is FailureResult<Map<String, dynamic>>) {
  //     emit(ForgotPasswordFailureState(result.exception.toString()));
  //   }
  // }

  // Future<void> resendCode() async {
  //   emit(ForgotPasswordLoadingReSendState());
  //   String? email = await getEmail();
  //   // Check if the email is null and pass the email accordingly

  //   // If email is not null, update the request email and pass it
  //   final result = await useCase.forgotPassword(ForgotPasswordRequestDto(email: email!));

  //   // Handle success and failure results
  //   switch (result) {
  //     case SuccessResult<Map<String, dynamic>>():
  //       emit(ForgotPasswordSuccessResendState(result.data['message']));
  //       await saveEmail(email); // Save the email after success
  //       break; // Add break here to prevent falling through to the failure case
  //     case FailureResult<Map<String, dynamic>>():
  //       emit(ForgotPasswordFailureState(result.exception.toString()));
  //       break; // Add break here to prevent falling through
  //   }
  // }

  // Future<void> sendResetCode({required String code}) async {
  //   emit(ForgotPasswordLoadingSendState());
  //   final result = await useCase.verifyResetCode(VerifyResetCodeDtoRequest(
  //     resetCode: code,
  //   ));
  //   switch (result) {
  //     case SuccessResult<Map<String, dynamic>>():
  //       {
  //         Future.delayed(Duration(seconds: 1), () {
  //           emit(ForgotPasswordSuccessState(result.data['status']));
  //         });
  //       }
  //     case FailureResult<Map<String, dynamic>>():
  //       {
  //         Future.delayed(Duration(seconds: 1), () {
  //           emit(ForgotPasswordFailureState(result.exception.toString()));
  //         });
  //       }
  //   }
  // }

  // Future<void> verifyResetPassword(
  //     {required String newPassword, required String confirmPassword}) async {
  //   emit(ForgotPasswordLoadingResetState());
  //   String? email = await getEmail();

  //   print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]");
  //   print(email);
  //   final result = await useCase
  //       .resetPassword(ResetPasswordRequestDto(email: email!, newPassword: newPassword));
  //   switch (result) {
  //     case SuccessResult<Map<String, dynamic>>():
  //       {
  //         Future.delayed(Duration(seconds: 1), () {
  //           emit(ForgotPasswordSuccessResetState(result.data['message']));
  //         });
  //       }
  //     case FailureResult<Map<String, dynamic>>():
  //       {
  //         Future.delayed(Duration(seconds: 1), () {
  //           emit(ForgotPasswordFailureResetState(result.exception.toString()));
  //         });
  //       }
  //   }
  // }
}
