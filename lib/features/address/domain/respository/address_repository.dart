import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/address/data/model/address_request_model.dart';

abstract class AddressRepository {
  Future<Result<String>>saveAddress(AddressRequestModel addressRequest);
  Future<Result<String>> editAddress(String id, AddressRequestModel addressRequest);
}