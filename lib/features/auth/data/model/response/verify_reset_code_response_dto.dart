import 'package:flowery_app/features/auth/domain/entity/forgot_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_response_dto.g.dart';

@JsonSerializable()
class VerifyResetCodeResponseDto {
  String? status;

  VerifyResetCodeResponseDto({this.status});

  factory VerifyResetCodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseDtoFromJson(json);

  ForgotPasswordResponseEntity toEntity() {
    return ForgotPasswordResponseEntity(
      message: "",
      info: "",
      status: status ?? "",
      token: "",
    );
  }
}
