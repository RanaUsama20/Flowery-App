import 'package:flowery_app/core/utils/save_local.dart';
import 'package:flowery_app/features/auth/domain/entity/login_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginDataSource loginDataSource;

  LoginRepositoryImpl(this.loginDataSource);

  @override
  Future<LoginEntity?> call({required String email, required String password}) async {
    var response =  await loginDataSource.call(email: email, password: password);
    SaveLocal.saveString("token", response!.token!);
    return response;
  }

}
