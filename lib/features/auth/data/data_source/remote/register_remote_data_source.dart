import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';

abstract class RegisterRemoteDataSource {
  Future<String>register(RegisterRequestModel registerRequest);
}