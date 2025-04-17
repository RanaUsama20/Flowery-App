import 'package:dio/dio.dart';
import 'package:flowery_app/features/auth/data/model/response/forgot_password_response_dto.dart';
import 'package:flowery_app/features/auth/data/model/response/reset_password_response_dto.dart';
import 'package:flowery_app/features/auth/data/model/response/verify_reset_code_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../model/login/login_dto.dart';
import '../model/request/forgot_password_request_dto.dart';
import '../model/request/register_request_model.dart';
import '../model/request/reset_password_request.dart';
import '../model/request/verify_reset_code_request_dto.dart';
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

   @GET(ApiConstants.logOut)
  Future<String> logout(@Header('Authorization') String? token);


  @POST('/auth/signin')
  Future<LoginDto?> login(@Field("email") String email, @Field("password") String password);
  Future<RegisterResponse> register(@Body() RegisterRequestModel registerRequest);

  @POST(ApiConstants.loginRoute)
  Future<LoginDto?> login(
      @Field("email") String email, @Field("password") String password);

  @POST(ApiConstants.forgetPasswordRoute)
  Future<ForgotPasswordResponseDto> forgotPassword(
      @Body() ForgotPasswordRequestDto request);

  @POST(ApiConstants.verifyOtpCodeRoute)
  Future<VerifyResetCodeResponseDto> verifyResetCode(
      @Body() VerifyResetCodeDtoRequest request);

  @PUT(ApiConstants.resetPasswordRoute)
  Future<ResetPasswordResponseDto> resetPassword(@Body() ResetPasswordRequestDto request);
}
