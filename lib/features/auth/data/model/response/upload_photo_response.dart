import 'package:json_annotation/json_annotation.dart';
part 'upload_photo_response.g.dart';

@JsonSerializable()
class UploadPhotoResponse {
  String? message;

  UploadPhotoResponse({this.message});
  factory UploadPhotoResponse.fromJson(Map<String,dynamic> json)=>_$UploadPhotoResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$UploadPhotoResponseToJson(this);
}