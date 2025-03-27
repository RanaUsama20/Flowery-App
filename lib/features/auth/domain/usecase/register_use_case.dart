import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';
import 'package:flowery_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  AuthRepository _authRepository;
  RegisterUseCase(this._authRepository);
  Future<Result<String>> call(RegisterRequestModel registerRequest) =>
      _authRepository.register(registerRequest);
}
