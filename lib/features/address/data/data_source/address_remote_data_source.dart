import 'package:flowery_app/features/address/data/model/address_request_model.dart';


abstract class AddressRemoteDataSource {
  Future<String> saveAddress(AddressRequestModel addressRequest);
  Future<String> editAddress(String id, AddressRequestModel addressRequest);
}
