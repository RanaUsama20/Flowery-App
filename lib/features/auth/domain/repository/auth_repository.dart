import '../entity/login_entity.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';
import '../../../../core/network/common/api_result.dart';
import '../../data/api/auth_retrofit_client.dart';
import '../../data/model/request/forgot_password_request.dart';
import '../../data/model/request/reset_password_request.dart';
import '../../data/model/request/verify_request_model.dart';

abstract class AuthRepository{

  Future<Result<Map<String,dynamic>>>forgotPassword( ForgotPasswordRequest request);
  Future<Result<Map<String,dynamic>>>verifyResetCode(VerifyResetCodeRequest request);
  Future<Result<Map<String, dynamic>>> resetPassword(ResetPasswordRequest request);
  Future<Result<String>> register(RegisterRequestModel registerRequest);
  Future<LoginEntity?> login({required String email, required String password});
  }