import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/domain/entity/forgot_password_response_entity.dart';
import 'package:injectable/injectable.dart';
import '../repository/auth_repository.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepository _authRepository;

  VerifyResetCodeUseCase(this._authRepository);

  Future<Result<ForgotPasswordResponseEntity>> call({required String code}) =>
      _authRepository.verifyResetCode(code: code);
}
