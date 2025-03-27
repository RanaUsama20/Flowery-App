import '../entity/login_entity.dart';

abstract class LoginRepository{
Future<LoginEntity?>call({required String email, required String password});
}