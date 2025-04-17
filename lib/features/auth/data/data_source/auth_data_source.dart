import 'dart:io';

import 'package:flowery_app/features/auth/data/model/request/edit_profile_request.dart';

import '../../domain/entity/login_entity.dart';

import 'package:flowery_app/core/network/common/api_result.dart';
import '../model/request/forgot_password_request.dart';
import '../model/request/reset_password_request.dart';
import '../model/request/verify_request_model.dart';


abstract class AuthDataSource {

 Future<Result<Map<String, dynamic>>> forgotPassword(
     ForgotPasswordRequest request);

 Future<Result<Map<String, dynamic>>> verifyResetCode(
     VerifyResetCodeRequest request);

 Future<Result<Map<String, dynamic>>> resetPassword(
     ResetPasswordRequest request);

 Future<LoginEntity?> login({required String email, required String password});
 Future<Result<String>>editProfile(EditProfileRequest request);
 Future<Result<String>>uploadPhoto(File request);



}