import 'dart:io';

import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/utils/save_local.dart';
import 'package:flowery_app/features/auth/domain/entity/login_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/remote/api_manager.dart';
import '../../../profile/data/api/profile_retrofit_client.dart';
import '../../domain/entity/forgot_password_response_entity.dart';
import '../api/auth_retrofit_client.dart';
import '../api/upload_photo_api_service.dart';
import '../model/login/login_dto.dart';
import '../model/request/edit_profile_request.dart';
import '../model/request/forgot_password_request_dto.dart';
import '../model/request/reset_password_request.dart';
import '../model/request/verify_reset_code_request_dto.dart';
import '../model/response/forgot_password_response_dto.dart';
import '../model/response/reset_password_response_dto.dart';
import '../model/response/verify_reset_code_response_dto.dart';
import 'auth_data_source.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiManager apiManager;
  final AuthRetrofitClient apiService;
  final ProfileRetrofitClient apiServiceProfile;

  final UploadPhotoApiService authApiService;

  AuthRetrofitClient apiClient;

  AuthDataSourceImpl(this.apiService, this.apiManager, this.apiClient,this.authApiService,this.apiServiceProfile);

  @override
  Future<Result<ForgotPasswordResponseEntity>> forgotPassword(
      {required String email}) async {
    final result = await apiManager.execute<ForgotPasswordResponseDto>(() async {
      final response =
          await apiService.forgotPassword(ForgotPasswordRequestDto(email: email));
      return response;
    });

    switch (result) {
      case SuccessResult<ForgotPasswordResponseDto>():
        return SuccessResult<ForgotPasswordResponseEntity>(result.data.toEntity());
      case FailureResult<ForgotPasswordResponseDto>():
        return FailureResult<ForgotPasswordResponseEntity>(result.exception);
    }
  }

  @override
  Future<Result<ForgotPasswordResponseEntity>> verifyResetCode(
      {required String code}) async {
    final result = await apiManager.execute<VerifyResetCodeResponseDto>(() async {
      final response =
          await apiService.verifyResetCode(VerifyResetCodeDtoRequest(resetCode: code));
      return response;
    });

    switch (result) {
      case SuccessResult<VerifyResetCodeResponseDto>():
        return SuccessResult<ForgotPasswordResponseEntity>(result.data.toEntity());
      case FailureResult<VerifyResetCodeResponseDto>():
        return FailureResult<ForgotPasswordResponseEntity>(result.exception);
    }
  }

  @override
  Future<Result<ForgotPasswordResponseEntity>> resetPassword(
      {required String email, required String newPassword}) async {
    final result = await apiManager.execute<ResetPasswordResponseDto>(() async {
      final response = await apiService
          .resetPassword(ResetPasswordRequestDto(email: email, newPassword: newPassword));
      return response;
    });

    switch (result) {
      case SuccessResult<ResetPasswordResponseDto>():
        return SuccessResult<ForgotPasswordResponseEntity>(result.data.toEntity());
      case FailureResult<ResetPasswordResponseDto>():
        return FailureResult<ForgotPasswordResponseEntity>(result.exception);
    }
  }

  @override
  Future<Result<LoginEntity>> login({required String email, required String password}) async {
    final result = await apiManager.execute<LoginDto>(() async {
      final response = await apiService.login(email, password);

      if (response == null) {
        throw Exception("Null response from login API");
      }

      return response;
    });
    switch (result) {
      case SuccessResult<LoginDto>():
        return SuccessResult<LoginEntity>(result.data.toLoginEntity());
      case FailureResult<LoginDto>():
        return FailureResult<LoginEntity>(result.exception);
    }
  }
  @override
  Future<String> logout() async {
    final token = await SaveLocal.getString("token");
    final fullToken = "Bearer $token";
    final response = await apiService.logout(fullToken);
    return response;
  }
  @override
  Future<Result<String>> editProfile(EditProfileRequest request) async {
    return await apiManager.execute<String>(() async {
      final token = await SaveLocal.getString("token");
      if (token == null) {
        throw Exception("Token is not available");
      }

      final response = await apiServiceProfile.editProfile(" Bearer ${token}",request);
      print(SaveLocal.getString("token").toString());
      return response.message!;
    });
  }

  @override
  Future<Result<String>> uploadPhoto(File request) async{
    return await apiManager.execute<String>(() async {
      final token = await SaveLocal.getString("token");
      if (token == null) {
        throw Exception("Token is not available");
      }

      final response = await authApiService.uploadPhoto(request);
      print(SaveLocal.getString("token").toString());
      print("llllllllllllllllllllllllllllllllllllllllllllllll");
      print(response.toString());
      return response.toString();

    });
  }


}
