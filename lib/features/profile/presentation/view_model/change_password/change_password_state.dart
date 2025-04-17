
import 'package:equatable/equatable.dart';
import '../../../../../../core/base_state/base_state.dart';

class ChangePasswordState extends Equatable {
  final BaseState? baseState;
  final bool isFormValid;



  const ChangePasswordState({
    this.baseState,
    this.isFormValid = false,


  });

  ChangePasswordState copyWith({
    BaseState? baseState,
    bool? isFormValid,


  }) {
    return ChangePasswordState(
      baseState: baseState ?? this.baseState,
      isFormValid: isFormValid ?? this.isFormValid,


    );
  }

  @override
  List<Object?> get props => [baseState];

}

sealed class ChangePasswordAction {}


final class UpdatePasswordAction extends ChangePasswordAction {}


