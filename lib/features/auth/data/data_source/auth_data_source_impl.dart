import 'dart:io';

import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/data/api/upload_photo_api_service.dart';
import 'package:flowery_app/features/auth/data/model/request/edit_profile_request.dart';
import 'package:flowery_app/features/auth/data/model/request/forgot_password_request.dart';
import 'package:flowery_app/features/auth/data/model/request/verify_request_model.dart';
import 'package:flowery_app/features/auth/domain/entity/login_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/remote/api_manager.dart';
import '../../../../core/utils/save_local.dart';
import '../api/auth_retrofit_client.dart';
import '../model/request/reset_password_request.dart';
import 'auth_data_source.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiManager apiManager;
  final AuthRetrofitClient apiService;
  final UploadPhotoApiService authApiService;

  AuthRetrofitClient apiClient;

  AuthDataSourceImpl(this.apiService, this.apiManager, this.apiClient,this.authApiService);

  @override
  Future<Result<Map<String, dynamic>>> forgotPassword(
      ForgotPasswordRequest request) async {
    return await apiManager.execute<Map<String, dynamic>>(() async {
      final response = await apiService.forgotPassword(request);
      return response;
    });
  }

  @override
  Future<Result<Map<String, dynamic>>> verifyResetCode(
      VerifyResetCodeRequest request) async {
    return await apiManager.execute<Map<String, dynamic>>(() async {
      final response = await apiService.verifyResetCode(request);

      return response;
    });
  }

  @override
  Future<Result<Map<String, dynamic>>> resetPassword(ResetPasswordRequest request) async {
    return await apiManager.execute<Map<String, dynamic>>(() async {
      final response = await apiService.resetPassword(request);
      return response;
    });
  }

  @override
  Future<LoginEntity?> login({required String email, required String password}) async {
    var response = await apiClient.login(email, password);

    return response?.toLoginEntity();
  }
  @override
  Future<Result<String>> editProfile(EditProfileRequest request) async {
    return await apiManager.execute<String>(() async {
      final token = await SaveLocal.getString("token");
      if (token == null) {
        throw Exception("Token is not available");
      }

      final response = await apiService.editProfile(" Bearer ${token}",request);
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
