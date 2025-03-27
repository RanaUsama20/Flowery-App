import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/network/remote/api_manager.dart';
import 'package:flowery_app/features/auth/data/data_source/remote/register_remote_data_source.dart';
import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';
import 'package:flowery_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final RegisterRemoteDataSource _registerRemoteDataSource;
  final ApiManager _apiManager;
  AuthRepositoryImpl(this._registerRemoteDataSource, this._apiManager);
  @override
  Future<Result<String>> register(RegisterRequestModel registerRequest) async {
    final ans = await _apiManager.execute(() {
      return _registerRemoteDataSource.register(registerRequest);
    });
    return ans;
  }
}
