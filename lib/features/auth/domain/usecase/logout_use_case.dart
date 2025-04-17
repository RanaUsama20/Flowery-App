import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);
  Future<Result<String>> call() => _authRepository.logout();
}
