import 'package:flowery_app/features/auth/domain/entity/forgot_password_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequestDto {
  final String? email;
  final String? newPassword;

  ResetPasswordRequestDto({
    this.email,
    this.newPassword,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordRequestDtoToJson(this);

  // toEntity
  ForgotPasswordRequestEntity toEntity() {
    return ForgotPasswordRequestEntity(
      email: email ?? "",
      resetCode: "",
      newPassword: newPassword ?? "",
    );
  }
}
