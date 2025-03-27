import 'package:flowery_app/features/auth/data/model/response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  String? message;
  UserResponse? user;
  String? token;

  RegisterResponse({this.message, this.user, this.token});
  factory RegisterResponse.fromJson(Map<String,dynamic> json)=>_$RegisterResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$RegisterResponseToJson(this);
}