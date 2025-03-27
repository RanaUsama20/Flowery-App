import '../../domain/entity/login_entity.dart';

import 'package:flowery_app/core/network/common/api_result.dart';

import '../api/auth_retrofit_client.dart';
import '../model/request/forgot_password_request.dart';
import '../model/request/reset_password_request.dart';
import '../model/request/verify_request_model.dart';


abstract class AuthDataSource {

 Future<Result<Map<String,dynamic>>> forgotPassword( ForgotPasswordRequest request);
 Future<Result<Map<String,dynamic>>> verifyResetCode(VerifyResetCodeRequest request);
 Future<Result<Map<String, dynamic>>> resetPassword(ResetPasswordRequest request);
abstract class LoginDataSource {
Future<LoginEntity?> call({required String email, required String password});
}
