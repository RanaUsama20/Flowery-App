import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/domain/entity/forgot_password_response_entity.dart';
import 'package:flowery_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepository _authRepository;

  ForgotPasswordUseCase(this._authRepository);

  Future<Result<ForgotPasswordResponseEntity>> call({required String email}) =>
      _authRepository.forgotPassword(email: email);
}
