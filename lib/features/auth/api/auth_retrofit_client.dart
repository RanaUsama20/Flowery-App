import 'package:dio/dio.dart';
import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';
import 'package:flowery_app/features/auth/data/model/response/register_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/remote/api_constants.dart';

part 'auth_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @POST(ApiConstants.signupRoute)
  Future<RegisterResponse> register(
      @Body() RegisterRequestModel registerRequest);
}
