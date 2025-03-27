
import 'package:injectable/injectable.dart';

import '../../../../core/network/common/api_result.dart';
import '../../domain/repository/auth_repository.dart';
import '../api/auth_retrofit_client.dart';
import '../data_source/auth_data_source.dart';
import '../model/request/forgot_password_request.dart';
import '../model/request/reset_password_request.dart';
import '../model/request/verify_request_model.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Result<Map<String,dynamic>>> forgotPassword( ForgotPasswordRequest request)async {
    final result = await authDataSource.forgotPassword( request);
    print(result);
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    return result;
  }
  @override
  Future<Result<Map<String,dynamic>>> verifyResetCode(VerifyResetCodeRequest request)async {
    final result = await authDataSource.verifyResetCode( request);
    return result;
  }
  @override
  Future<Result<Map<String, dynamic>>> resetPassword(
      ResetPasswordRequest request) async {
    final result = await authDataSource.resetPassword(request);
    return result;
  }
}
