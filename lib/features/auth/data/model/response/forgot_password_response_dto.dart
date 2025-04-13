import 'package:flowery_app/features/auth/domain/entity/forgot_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response_dto.g.dart';

@JsonSerializable()
class ForgotPasswordResponseDto {
  String? message;
  String? info;

  ForgotPasswordResponseDto({this.message, this.info});

  factory ForgotPasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseDtoFromJson(json);

  // toEntity
  ForgotPasswordResponseEntity toEntity() {
    return ForgotPasswordResponseEntity(
      message: message ?? "",
      info: info ?? "",
      status: "",
      token: "",
    );
  }
}
