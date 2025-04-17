import 'package:flowery_app/features/auth/data/model/response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'edit_profile_response.g.dart';

@JsonSerializable()
class EditProfileResponse {
  String? message;
  UserResponse? user;

  EditProfileResponse({this.message, this.user});
  factory EditProfileResponse.fromJson(Map<String,dynamic> json)=>_$EditProfileResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$EditProfileResponseToJson(this);
}