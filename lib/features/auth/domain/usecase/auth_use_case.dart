import 'dart:io';

import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/data/model/request/edit_profile_request.dart';
import 'package:injectable/injectable.dart';
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
  Future<Result<String>> editProfile(EditProfileRequest request) async
  {

    return await authRepo.editProfile(request);
  }
  Future<Result<String>> uploadPhoto(File request) async
  {

    return await authRepo.uploadPhoto(request);
  }
}
