import 'package:flowery_app/features/auth/domain/entity/forgot_password_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request_dto.g.dart';

@JsonSerializable()
class ForgotPasswordRequestDto {
  final String? email;

  ForgotPasswordRequestDto({this.email});

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestDtoToJson(this);

  // to entity
  ForgotPasswordRequestEntity toEntity() {
    return ForgotPasswordRequestEntity(
      email: email ?? "",
      resetCode: "",
      newPassword: "",
    );
  }
}
