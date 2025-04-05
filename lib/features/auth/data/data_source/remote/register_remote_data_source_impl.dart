
import 'package:flowery_app/features/auth/data/data_source/remote/register_remote_data_source.dart';
import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';
import 'package:injectable/injectable.dart';

import '../../api/auth_retrofit_client.dart';

@Injectable(as: RegisterRemoteDataSource)
class RegisterDataSourceImpl implements RegisterRemoteDataSource {
  AuthRetrofitClient _authRetrofitClient;

  RegisterDataSourceImpl(this._authRetrofitClient);

  @override
  Future<String> register(RegisterRequestModel registerRequest) async {
    final ans = await _authRetrofitClient.register(registerRequest);
    return ans.message!;
  }
}
