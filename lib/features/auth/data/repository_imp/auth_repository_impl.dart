import 'package:flowery_app/features/auth/domain/entity/forgot_password_response_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../../core/network/remote/api_manager.dart';
import '../../../../core/utils/save_local.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';
import '../data_source/remote/register_remote_data_source.dart';
import '../model/request/register_request_model.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final RegisterRemoteDataSource _registerRemoteDataSource;
  final AuthDataSource authDataSource;

  final ApiManager _apiManager;

  AuthRepositoryImpl(
      this._registerRemoteDataSource, this._apiManager, this.authDataSource);

  @override
  Future<Result<String>> register(RegisterRequestModel registerRequest) async {
    final ans = await _apiManager.execute(() {
      return _registerRemoteDataSource.register(registerRequest);
    });
    return ans;
  }

  @override
  Future<LoginEntity?> login({required String email, required String password}) async {
    var response = await authDataSource.login(email: email, password: password);
    SaveLocal.saveString("token", response!.token!);
    return response;
  }

  @override
  Future<Result<ForgotPasswordResponseEntity>> forgotPassword({required String email}) {
    return authDataSource.forgotPassword(email: email);
  }

  @override
  Future<Result<ForgotPasswordResponseEntity>> resetPassword(
      {required String email, required String newPassword}) {
    return authDataSource.resetPassword(email: email, newPassword: newPassword);
  }

  @override
  Future<Result<ForgotPasswordResponseEntity>> verifyResetCode({required String code}) {
    return authDataSource.verifyResetCode(code: code);
  }

  // @override
  // Future<Result<Map<String, dynamic>>> forgotPassword(
  //     ForgotPasswordRequestDto request) async {
  //   final result = await authDataSource.forgotPassword(request);

  //   return result;
  // }

  // @override
  // Future<Result<Map<String, dynamic>>> verifyResetCode(
  //     VerifyResetCodeDtoRequest request) async {
  //   final result = await authDataSource.verifyResetCode(request);
  //   return result;
  // }

  // @override
  // Future<Result<Map<String, dynamic>>> resetPassword(
  //     ResetPasswordRequestDto request) async {
  //   final result = await authDataSource.resetPassword(request);
  //   return result;
  // }
}
