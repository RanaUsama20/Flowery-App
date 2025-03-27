import 'package:json_annotation/json_annotation.dart';
part 'verify_request_model.g.dart';
@JsonSerializable()
class VerifyResetCodeRequest {
  final String resetCode;

  VerifyResetCodeRequest({required this.resetCode});

  factory VerifyResetCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeRequestToJson(this);
}
