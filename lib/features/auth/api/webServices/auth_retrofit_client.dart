import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/network/remote/api_constants.dart';
import '../../data/model/login/login_dto.dart';

part 'auth_retrofit_client.g.dart';
@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

}



@lazySingleton
@injectable
class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://flower.elevateegy.com/',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          "Content-Type": "application/json",
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    )
    ..interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log("API Response: ${response.statusCode} - ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log("Dio Error: ${e.message}");
          if (e.response != null) {
            log("Error Response: ${e.response!.data}");
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<LoginDto?> login(String email, String password) async {
    try {
      log(" Attempting to sign in with: Email: $email, Password: $password");

      final response = await _dio.post(
        '/api/v1/auth/signin',
        data: {
          "email": email,
          "password": password,
        },
      );

      log(" Response status: ${response.statusCode}");
      log(" Response data: ${response.data}");

      if (response.statusCode == 200) {
        var loginDto = LoginDto.fromJson(response.data);
        log(" User logged in: ${loginDto.user}");

        await _saveToken(loginDto.token!);

        return loginDto;
      } else if (response.statusCode == 401) {
        log(" Incorrect email or password");
        return null;
      } else {
        throw ServerException("Unexpected response: ${response.statusCode}");
      }
    } catch (e) {
      log(" Unknown error during login: ${e.toString()}");
      throw ServerException("Unexpected error occurred");
    }
  }


  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }
}class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => "ServerException: $message";
}

