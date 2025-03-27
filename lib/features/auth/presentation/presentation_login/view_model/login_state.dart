import 'package:equatable/equatable.dart';
import '../../../../../core/error/failuer.dart';
import '../../../domain/entity/login_entity.dart';

sealed class LoginStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
   LoginEntity loginEntity;
   String message = '';
  LoginSuccessState({required this.loginEntity, this.message = ''});

  @override
  List<Object> get props => [loginEntity];
}

class LoginErrorState extends LoginStates {
  final Failure error;
  LoginErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class LoginRememberMe extends LoginStates {
  final bool isChecked;
  LoginRememberMe(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}
