import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../model/login/login_dto.dart';
import '../model/request/forgot_password_request.dart';
import '../model/request/register_request_model.dart';
import '../model/request/reset_password_request.dart';
import '../model/request/verify_request_model.dart';
import '../model/response/register_response.dart';
part 'auth_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;
  @POST(ApiConstants.signupRoute)
  Future<RegisterResponse> register(
      @Body() RegisterRequestModel registerRequest);
  @POST('/auth/signin')
  Future<LoginDto?> login(
      @Field("email") String email, @Field("password") String password);

  @POST("auth/forgotPassword")
  Future<Map<String, dynamic>> forgotPassword(
    @Body() ForgotPasswordRequest request,
  );

  @POST("auth/verifyResetCode")
  Future<Map<String, dynamic>> verifyResetCode(
      @Body() VerifyResetCodeRequest request);
  @PUT("auth/resetPassword")
  Future<Map<String, dynamic>> resetPassword(
      @Body() ResetPasswordRequest request);
}
