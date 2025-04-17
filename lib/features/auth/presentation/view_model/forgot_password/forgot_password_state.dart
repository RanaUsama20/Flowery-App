import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/enum/status.dart';

extension RegisterStatusX on ForgetPasswordState {
  // send email
  bool get isForgotPasswordLoading => forgotPasswordStatus == Status.loading;
  bool get isForgotPasswordSuccess => forgotPasswordStatus == Status.success;
  bool get isForgotPasswordError => forgotPasswordStatus == Status.failure;
  // send code
  bool get isVerifyResetCodeLoading => verifyResetCodeStatus == Status.loading;
  bool get isVerifyResetCodeSuccess => verifyResetCodeStatus == Status.success;
  bool get isVerifyResetCodeError => verifyResetCodeStatus == Status.failure;
  // reset password status
  bool get isResetPasswordLoading => resPasswordStatus == Status.loading;
  bool get isResetPasswordSuccess => resPasswordStatus == Status.success;
  bool get isResetPasswordError => resPasswordStatus == Status.failure;
}

class ForgetPasswordState extends Equatable {
  final Status forgotPasswordStatus;
  final Status verifyResetCodeStatus;
  final Status resPasswordStatus;
  final String errorMessage;
  final String email;
  const ForgetPasswordState({
    this.forgotPasswordStatus = Status.initial,
    this.verifyResetCodeStatus = Status.initial,
    this.resPasswordStatus = Status.initial,
    this.errorMessage = '',
    this.email = '',
  });
  ForgetPasswordState copyWith({
    Status? forgotPasswordStatus,
    Status? verifyResetCodeStatus,
    Status? resPasswordStatus,
    String? errorMessage,
    String? email,
  }) {
    return ForgetPasswordState(
      forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus,
      verifyResetCodeStatus: verifyResetCodeStatus ?? this.verifyResetCodeStatus,
      resPasswordStatus: resPasswordStatus ?? this.resPasswordStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [
        forgotPasswordStatus,
        errorMessage,
        email,
        verifyResetCodeStatus,
        resPasswordStatus
      ];
}
// abstract class ForgotPasswordState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class ForgotPasswordInitialState extends ForgotPasswordState {}

// class ForgotPasswordLoadingState extends ForgotPasswordState {}
// class ForgotPasswordLoadingResetState extends ForgotPasswordState {}
// class ForgotPasswordLoadingReSendState extends ForgotPasswordState {}
// class ForgotPasswordLoadingSendState extends ForgotPasswordState {}
// class ForgotPasswordSuccessState extends ForgotPasswordState {
//   final String message;

//   ForgotPasswordSuccessState(this.message);

//   @override
//   List<Object> get props => [message];
// }
// class ForgotPasswordSuccessResendState extends ForgotPasswordState {
//   final String message;

//   ForgotPasswordSuccessResendState(this.message);

//   @override
//   List<Object> get props => [message];
// }
// class ForgotPasswordSuccessResetState extends ForgotPasswordState {
//   final String message;

//   ForgotPasswordSuccessResetState(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class ForgotPasswordFailureState extends ForgotPasswordState {
//   final String errorMessage;

//   ForgotPasswordFailureState(this.errorMessage);

//   @override
//   List<Object> get props => [errorMessage];
// }

// class ForgotPasswordFailureResetState extends ForgotPasswordState {
//   final String errorMessage;

//   ForgotPasswordFailureResetState(this.errorMessage);

//   @override
//   List<Object> get props => [errorMessage];
// }
