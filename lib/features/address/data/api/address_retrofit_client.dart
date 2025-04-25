import 'package:dio/dio.dart';
import 'package:flowery_app/core/network/remote/api_constants.dart';
import 'package:flowery_app/features/address/data/model/address_request_model.dart';
import 'package:flowery_app/features/address/data/model/address_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'address_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AddressRetrofitClient {
  @factoryMethod
  factory AddressRetrofitClient(Dio dio) = _AddressRetrofitClient;

  @PATCH(ApiConstants.address)
  Future<AddressResponseModel> saveAddress(
      @Body() AddressRequestModel addressRequest,
      @Header('Authorization') String? token);

  @PATCH('${ApiConstants.editAddress}{id}')
  Future<AddressResponseModel> editAddress(
      @Path('id') String id,
      @Body() AddressRequestModel addressRequest,
      @Header('Authorization') String? token);
}
