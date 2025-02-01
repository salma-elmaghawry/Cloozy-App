class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}

class LoginResponse {
  final String message;
  final String token;

  LoginResponse({required this.message, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? 'Login successful',
      token: json['data']['token'] ?? '', // Access nested token
    );
  }
}
