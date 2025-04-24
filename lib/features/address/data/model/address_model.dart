import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';
@JsonSerializable()
class Address{
   String? street;
  String? phone;
  String? city;
  String? lat;
  String? long;
  String? username;
  @JsonKey(name: '_id')
  String? Id;

  Address(
      {this.street,
      this.phone,
      this.city,
      this.lat,
      this.long,
      this.username,
      this.Id});

 factory Address.fromJson(Map<String, dynamic> json)=>_$AddressFromJson(json); 

  Map<String, dynamic> toJson() =>_$AddressToJson(this);
}
