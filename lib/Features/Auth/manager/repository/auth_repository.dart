import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:cloozy/Features/Auth/manager/models/register_model.dart';

class AuthRepository {
  final String baseUrl = "https://cloozy.azurewebsites.net/api";

  Future<RegisterResonse> register(RegisterRequest data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data.toJson()),
    );
    if (response.statusCode == 200) {
      return RegisterResonse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to register: ${response.body}');
    }
  }
}
