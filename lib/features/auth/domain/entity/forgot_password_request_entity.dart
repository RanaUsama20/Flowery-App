// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ForgotPasswordRequestEntity extends Equatable {
  final String email;
  final String resetCode;
  final String newPassword;
  const ForgotPasswordRequestEntity({
    required this.email,
    required this.resetCode,
    required this.newPassword,
  });
  // copyWith
  ForgotPasswordRequestEntity copyWith({
    String? email,
    String? resetCode,
    String? newPassword,
  }) {
    return ForgotPasswordRequestEntity(
      email: email ?? this.email,
      resetCode: resetCode ?? this.resetCode,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  @override
  List<Object?> get props => [email, resetCode, newPassword];
}
