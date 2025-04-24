import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/network/remote/api_manager.dart';
import 'package:flowery_app/features/address/data/data_source/address_remote_data_source.dart';
import 'package:flowery_app/features/address/data/model/address_request_model.dart';
import 'package:flowery_app/features/address/domain/respository/address_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(  as: AddressRepository)
class HomeRepositoryImpl extends AddressRepository {
 final  ApiManager _apiManager;
 final  AddressRemoteDataSource _addressRemoteDataSource;
HomeRepositoryImpl(this._apiManager,this._addressRemoteDataSource);

  @override
  Future<Result<String>> saveAddress(AddressRequestModel addressRequest) async{
     final result=await  _apiManager.execute<String>(() async {
       return  _addressRemoteDataSource.saveAddress(addressRequest);
     });

     return result; 
    
  }
  
  @override
  Future<Result<String>> editAddress(String id, AddressRequestModel addressRequest)async {
   final result=await  _apiManager.execute<String>(() async {
       return  _addressRemoteDataSource.editAddress(id,addressRequest);
     });
     return result; 
  }
}