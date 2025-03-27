import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/data/model/request/forgot_password_request.dart';
import 'package:flowery_app/features/auth/data/model/request/verify_request_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/remote/api_manager.dart';
import '../api/auth_retrofit_client.dart';
import '../model/request/reset_password_request.dart';
import 'auth_data_source.dart';
@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource
{
  final ApiManager apiManager;
final  AuthRetrofitClient apiService;

AuthDataSourceImpl(this.apiService,this.apiManager);

  @override
  Future<Result<Map<String,dynamic>>>forgotPassword( ForgotPasswordRequest request) async {
    return await apiManager.execute<Map<String,dynamic>>(() async {
      final response = await apiService.forgotPassword(request);
      return response;

    });
  }

  @override
  Future<Result<Map<String,dynamic>>> verifyResetCode(VerifyResetCodeRequest request)async {
    return await apiManager.execute<Map<String,dynamic>>(() async {
    final response = await apiService.verifyResetCode(request);
    print(response['status']);
    print(response);
    print("0000000000000000000000000000000000000000");
    return response;
    });
  }
  @override
  Future<Result<Map<String, dynamic>>> resetPassword(
      ResetPasswordRequest request) async {
    return await apiManager.execute<Map<String, dynamic>>(() async {
      final response = await apiService.resetPassword(request);
      return response;
    });
  }
        }

