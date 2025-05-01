import 'dart:io';

import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/data/model/request/edit_profile_request.dart';
import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';
import 'package:flowery_app/features/auth/domain/entity/forgot_password_response_entity.dart';
import '../entity/login_entity.dart';

abstract class AuthRepository {
  Future<Result<ForgotPasswordResponseEntity>> forgotPassword({required String email});
  Future<Result<ForgotPasswordResponseEntity>> verifyResetCode({required String code});
  Future<Result<ForgotPasswordResponseEntity>> resetPassword(
      {required String email, required String newPassword});
  Future<Result<String>> register(RegisterRequestModel registerRequest);
  Future<Result<LoginEntity?>> login({required String email, required String password});
  Future<Result<String>> logout();
  Future<Result<String>> editProfile(EditProfileRequest request);
  Future<Result<String>> uploadPhoto(File request);
  }



