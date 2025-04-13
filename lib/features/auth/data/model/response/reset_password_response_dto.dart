import 'package:flowery_app/features/auth/domain/entity/forgot_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response_dto.g.dart';

@JsonSerializable()
class ResetPasswordResponseDto {
  String? message;
  String? token;

  ResetPasswordResponseDto({this.message, this.token});

  factory ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseDtoFromJson(json);
  ForgotPasswordResponseEntity toEntity() {
    return ForgotPasswordResponseEntity(
      message: message ?? "",
      info: "",
      status: "",
      token: token ?? "",
    );
  }
}
