import '../../../data/model/request/change_password/change_password_request_model.dart';

class ChangePasswordRequestEntity {
  final String password;
  final String newPassword;

  ChangePasswordRequestEntity({
    required this.password,
    required this.newPassword,
  });

  ChangePasswordRequestDto toDto() => ChangePasswordRequestDto(
      password: password,
      newPassword: newPassword
  );

}
