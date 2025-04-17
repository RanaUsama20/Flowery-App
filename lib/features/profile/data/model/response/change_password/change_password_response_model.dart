import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/change_password/change_password__response_entity.dart';
part 'change_password_response_model.g.dart';


@JsonSerializable()
class ChangePasswordResponseDto {
  ChangePasswordResponseDto({
      this.message,
      this.token,
  this.error});

  String? message;
  String? token;
  String? error;

  factory ChangePasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseDtoToJson(this);

  ChangePasswordResponseEntity toDomain() => ChangePasswordResponseEntity(
      message: message,
      token: token,
    error: error
  );

}

