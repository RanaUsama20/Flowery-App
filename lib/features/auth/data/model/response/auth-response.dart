class AuthResponse {
  final String message;
  final String status;

  AuthResponse({
    required this.message,
    required this.status,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'] as String,
      status: json['status'] as String,
    );
  }
}
