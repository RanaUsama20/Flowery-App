import 'package:flowery_app/features/address/data/model/address_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_response_model.g.dart';

@JsonSerializable()
class AddressResponseModel {
  String? message;
  List<Address>? address;

  AddressResponseModel({this.message, this.address});

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseModelToJson(this);
}
