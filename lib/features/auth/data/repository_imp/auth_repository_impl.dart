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
  final LoginDataSource loginDataSource;
  final ApiManager _apiManager;
  AuthRepositoryImpl(this._registerRemoteDataSource, this._apiManager, this.loginDataSource);
  @override
  Future<Result<String>> register(RegisterRequestModel registerRequest) async {
    final ans = await _apiManager.execute(() {
      return _registerRemoteDataSource.register(registerRequest);
    });
    return ans;

  }
  @override
  Future<LoginEntity?> login({required String email, required String password}) async {
    var response =  await loginDataSource.call(email: email, password: password);
    SaveLocal.saveString("token", response!.token!);
    return response;
  }



}
