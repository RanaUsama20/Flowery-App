import 'package:equatable/equatable.dart';
abstract class ForgotPasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}
class ForgotPasswordLoadingResetState extends ForgotPasswordState {}
class ForgotPasswordLoadingReSendState extends ForgotPasswordState {}
class ForgotPasswordLoadingSendState extends ForgotPasswordState {}
class ForgotPasswordSuccessState extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccessState(this.message);

  @override
  List<Object> get props => [message];
}
class ForgotPasswordSuccessResendState extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccessResendState(this.message);

  @override
  List<Object> get props => [message];
}
class ForgotPasswordSuccessResetState extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccessResetState(this.message);

  @override
  List<Object> get props => [message];
}

class ForgotPasswordFailureState extends ForgotPasswordState {
  final String errorMessage;

  ForgotPasswordFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ForgotPasswordFailureResetState extends ForgotPasswordState {
  final String errorMessage;

  ForgotPasswordFailureResetState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
