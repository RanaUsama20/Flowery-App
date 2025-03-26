import 'package:flowery_app/features/auth/domain/entity/login_entity.dart';

/// message : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3ZTMxZGNmNTU1NGIzMjg5MTI3MmM3ZSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzQyOTM3NjI2fQ.qvvHedO-M2AZFlS-UlG-ecrZ23AW25UN-hZNpGkO4q8"
/// user : {"_id":"67e31dcf5554b32891272c7e","username":"elevate11243","firstName":"Elevate","lastName":"Tech","email":"admin134@1elevate.com","phone":"01094155711","role":"user","isVerified":false,"createdAt":"2025-03-25T21:19:11.416Z"}

class LoginDto {
  LoginDto({
      this.message, 
      this.token, 
      this.user,});

  LoginDto.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? message;
  String? token;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

  LoginEntity toLoginEntity(){
    return LoginEntity(
      message:  message,
      user: user?.toUserEntity(),
    );
  }

}

/// _id : "67e31dcf5554b32891272c7e"
/// username : "elevate11243"
/// firstName : "Elevate"
/// lastName : "Tech"
/// email : "admin134@1elevate.com"
/// phone : "01094155711"
/// role : "user"
/// isVerified : false
/// createdAt : "2025-03-25T21:19:11.416Z"

class User {
  User({
      this.id, 
      this.username, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phone, 
      this.role, 
      this.isVerified, 
      this.createdAt,});

  User.fromJson(dynamic json) {
    id = json['_id']??'';
    username = json['username']??'';
    firstName = json['firstName']??'';
    lastName = json['lastName']??'';
    email = json['email']??'';
    phone = json['phone']??'';
    role = json['role']??'';
    isVerified = json['isVerified']as bool?;
    createdAt = json['createdAt']??'';
  }
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  bool? isVerified;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id??'';
    map['username'] = username??'';
    map['firstName'] = firstName??'';
    map['lastName'] = lastName??'';
    map['email'] = email??'';
    map['phone'] = phone??'';
    map['role'] = role??'';
    map['isVerified'] = isVerified as bool?;
    map['createdAt'] = createdAt??'';
    return map;
  }

  UserEntity toUserEntity(){
    return UserEntity(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      role: role,
      isVerified: isVerified,
      id: id,
      createdAt: createdAt,
    );
  }

}


