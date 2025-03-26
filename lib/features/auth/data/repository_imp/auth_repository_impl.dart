import 'package:flowery_app/features/auth/domain/entity/login_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginDataSource loginDataSource;

  LoginRepositoryImpl(this.loginDataSource);

  @override
  Future<LoginEntity?> call({required String email, required String password}) async {
    return  await loginDataSource.call(email: email, password: password);
  }

}
