import 'package:injectable/injectable.dart';

import '../entity/login_entity.dart';
import '../repository/auth_repository.dart';
@injectable
class LoginUseCase {
  AuthRepository loginRepository;
  LoginUseCase(this.loginRepository);
  Future<LoginEntity?>call({required String email, required String password})async {
    return  await loginRepository.login(email: email, password: password);
  }
}