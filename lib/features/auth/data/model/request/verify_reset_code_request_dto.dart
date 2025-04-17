import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/forgot_password_request_entity.dart';
part 'verify_reset_code_request_dto.g.dart';

@JsonSerializable()
class VerifyResetCodeDtoRequest {
  final String? resetCode;

  VerifyResetCodeDtoRequest({this.resetCode});

  Map<String, dynamic> toJson() => _$VerifyResetCodeDtoRequestToJson(this);

  ForgotPasswordRequestEntity toEntity() {
    return ForgotPasswordRequestEntity(
      email: "",
      resetCode: resetCode ?? "",
      newPassword: "",
    );
  }
}
