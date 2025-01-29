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
      this.roleId = 2});
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

class RegisterResonse {
  final String message;
  final String token;

  RegisterResonse({required this.message, required this.token});
  factory RegisterResonse.fromJson(Map<String, dynamic> json) {
    return RegisterResonse(
      message: json["message"],
      token: json["token"],
    );
  }
}
