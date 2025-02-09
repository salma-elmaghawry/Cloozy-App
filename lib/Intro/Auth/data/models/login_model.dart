class LoginRequest {
  final String email;
  final String password;
  final bool? remember;

  LoginRequest({required this.email, required this.password, this.remember});

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "remember": remember,
      };
}

class LoginResponse {
  final String message;
  final String token;
  final bool isEmailVerified;

  LoginResponse(
      {required this.message,
      required this.token,
      required this.isEmailVerified});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? 'Login successful',
      token: json['data']['token'] ?? '',
      isEmailVerified: json['data']['is_email_verified'] as bool? ?? false,
    );
  }
}
