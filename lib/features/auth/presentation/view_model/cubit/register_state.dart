

import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/base_state/base_state.dart';

class RegisterState extends Equatable {
  final BaseState? registerState;
  const RegisterState({this.registerState});
  RegisterState copyWith({BaseState? registerState}) {
    return RegisterState(registerState: registerState ?? this.registerState);
  }

  @override
  List<Object?> get props => [registerState];
}
