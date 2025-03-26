import '../../domain/entity/login_entity.dart';

abstract class LoginDataSource {
Future<LoginEntity?> call({required String email, required String password});
}
