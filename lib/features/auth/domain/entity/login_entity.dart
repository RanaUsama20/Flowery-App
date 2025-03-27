import 'package:equatable/equatable.dart';

class LoginEntity {
  String? message;
  UserEntity? user;

  LoginEntity({this.message, this.user});

}

class UserEntity {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  bool? isVerified;
  String? createdAt;

  UserEntity(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.role,
      this.isVerified,
      this.createdAt});
}