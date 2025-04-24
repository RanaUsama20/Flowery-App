import 'package:flowery_app/core/utils/save_local.dart';
import 'package:flowery_app/features/address/data/api/address_retrofit_client.dart';
import 'package:flowery_app/features/address/data/data_source/address_remote_data_source.dart';
import 'package:flowery_app/features/address/data/model/address_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRemoteDataSource)
class AddressRemoteDataSourceImpl extends AddressRemoteDataSource {
  final AddressRetrofitClient _addressRetrofitClient;
  AddressRemoteDataSourceImpl(this._addressRetrofitClient);
  @override
  Future<String> saveAddress(AddressRequestModel addressRequest) async {
    // final token =
    //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjdmNmU2YTNhOTgzMmQ4MzU5ZGRjODhjIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NDU1Mjg3NjJ9.zQKHDQ0AmcLSAArdll1wMbFFBImafla7TNGsSHKPKJA';
    final token = await SaveLocal.getString("token");
    final fullToken = "Bearer $token";
    final result =
        await _addressRetrofitClient.saveAddress(addressRequest, fullToken);
    return result.message!;
  }

  @override
  Future<String> editAddress(
      String id, AddressRequestModel addressRequest) async {
    final token = await SaveLocal.getString("token");
    final fullToken = "Bearer $token";
    final result =
        await _addressRetrofitClient.editAddress(id, addressRequest, fullToken);
    return result.message!;
  }
}
