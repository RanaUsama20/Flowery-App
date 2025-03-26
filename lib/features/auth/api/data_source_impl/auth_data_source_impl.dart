import 'package:flowery_app/features/auth/domain/entity/login_entity.dart';
import 'package:injectable/injectable.dart';
import '../../data/data_source/auth_data_source.dart';
import '../webServices/auth_retrofit_client.dart';

@Injectable(as: LoginDataSource)
class LoginDataSourceImpl implements LoginDataSource {
  AuthRetrofitClient apiClient;

  LoginDataSourceImpl(this.apiClient);

  @override
  Future<LoginEntity?> call({required String email, required String password}) async {
    var response = await apiClient.login(email, password);

    return response?.toLoginEntity();
  }
}
