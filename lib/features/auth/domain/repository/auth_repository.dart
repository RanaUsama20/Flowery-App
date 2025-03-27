import '../entity/login_entity.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';

abstract class AuthRepository {
  Future<Result<String>> register(RegisterRequestModel registerRequest);

  Future<LoginEntity?> login({required String email, required String password});
}