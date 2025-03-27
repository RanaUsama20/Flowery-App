import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../model/request/forgot_password_request.dart';
import '../model/request/reset_password_request.dart';
import '../model/request/verify_request_model.dart';
part 'auth_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @POST("auth/forgotPassword")
  Future<Map<String,dynamic>> forgotPassword(
      @Body() ForgotPasswordRequest request,
      );

  @POST("auth/verifyResetCode")
  Future<Map<String,dynamic>> verifyResetCode(
      @Body() VerifyResetCodeRequest request);
  @PUT("auth/resetPassword")
  Future<Map<String, dynamic>> resetPassword(
      @Body() ResetPasswordRequest request);
}
