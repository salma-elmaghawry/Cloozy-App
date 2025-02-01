class RegisterRequest {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String gender;
  final String passwordConfirmation;
  final int roleId;
  RegisterRequest(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.gender,
      required this.passwordConfirmation,
      required this.roleId});
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "gender": gender,
        "password_confirmation": passwordConfirmation,
        "role_id": roleId,
      };
}

class RegisterResponse {
  final String message;
  final String token;

  RegisterResponse({required this.message, required this.token});
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] ?? 'No message',
      token: json['token'] ?? '',
    );
  }
}
