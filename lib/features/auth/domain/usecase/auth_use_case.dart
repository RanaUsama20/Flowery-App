import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:injectable/injectable.dart';

import '../../data/api/auth_retrofit_client.dart';
import '../../data/model/request/forgot_password_request.dart';
import '../../data/model/request/reset_password_request.dart';
import '../../data/model/request/verify_request_model.dart';
import '../repository/auth_repository.dart';
@injectable
class AuthUseCase {
  final AuthRepository authRepo;

  AuthUseCase(this.authRepo);
  Future<Result<Map<String,dynamic>>> forgotPassword( ForgotPasswordRequest request)
 {

   return authRepo.forgotPassword(request);
 }

  Future<Result<Map<String,dynamic>>>verifyResetCode(VerifyResetCodeRequest request) async {
    return await authRepo.verifyResetCode(request);
  }
  Future<Result<Map<String, dynamic>>> resetPassword(ResetPasswordRequest request) async
  {

    return await authRepo.resetPassword(request);
  }
}
