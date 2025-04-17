import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/domain/entity/forgot_password_response_entity.dart';
import 'package:flowery_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository _authRepository;
  ResetPasswordUseCase(this._authRepository);

  Future<Result<ForgotPasswordResponseEntity>> call(
          {required String email, required String newPassword}) =>
      _authRepository.resetPassword(email: email, newPassword: newPassword);
}
