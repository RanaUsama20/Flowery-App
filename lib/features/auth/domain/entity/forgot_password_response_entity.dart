// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ForgotPasswordResponseEntity extends Equatable {
  final String message;
  final String info;
  final String status;
  final String token;
  const ForgotPasswordResponseEntity({
    required this.message,
    required this.info,
    required this.status,
    required this.token,
  });
  // copyWith
  ForgotPasswordResponseEntity copyWith({
    String? message,
    String? info,
    String? status,
    String? token,
  }) {
    return ForgotPasswordResponseEntity(
      message: message ?? this.message,
      info: info ?? this.info,
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [message, info, status, token];
}
