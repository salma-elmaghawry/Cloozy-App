import 'dart:convert';
import 'package:cloozy/Brand/Feature/Auth/data/services/secure_storage.dart';
import 'package:cloozy/Brand/Core/helper/assets.dart';
import 'package:cloozy/Brand/Feature/Auth/data/models/login_model.dart';
import 'package:cloozy/Brand/Feature/Auth/data/models/register_model.dart';
import 'package:cloozy/Brand/Feature/Auth/data/models/roles_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static const headers = {'Content-Type': 'application/json'};

  // Roles method
  Future<List<Role>> getRoles() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/pre-register'),
        headers: headers,
      );

      print('✅ Received response: ${response.statusCode}');
      print('📥 Response Data: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        List rolesData = responseData['data']['roles'];
        return rolesData.map<Role>((json) => Role.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch roles");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error fetching roles");
    }
  }

  // Registration method
  Future<RegisterResponse> register(RegisterRequest data) async {
    try {
      print('⏳ Starting registration request...');
      print('📤 Request Data: ${data.toJson()}');

      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {
          ...headers,
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toJson()),
      );

      print('✅ Received response: ${response.statusCode}');
      print('📥 Response Data: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          responseData['message'] == 'User registered successfully.') {
        final token = responseData['data']['token'] as String;
        await SecureStorage.saveToken(token);
        return RegisterResponse.fromJson(responseData);
      } else {
        throw parseErrorResponse(responseData);
      }
    } catch (e) {
      print('❌ Error: $e');
      throw parseErrorResponse({'message': e.toString()});
    }
  }

  // Login method
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(responseData);
        await SecureStorage.saveToken(loginResponse.token);
        return loginResponse;
      } else {
        throw parseErrorResponse(responseData);
      }
    } catch (e) {
      throw parseErrorResponse({'message': e.toString()});
    }
  }

  // Email verification
  Future<void> verifyEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-email'),
        headers: {'Accept': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      print('✅ Verify Email Response: ${response.statusCode}');
      print('📥 Response Data: ${response.body}');

      if (response.statusCode != 200) {
        throw parseErrorResponse(jsonDecode(response.body));
      }
    } catch (e) {
      throw parseErrorResponse({'message': e.toString()});
    }
  }

  // OTP verification
  Future<String> verifyEmailOtp(String otp) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) throw Exception('Authentication required');

      final response = await http.post(
        Uri.parse('$baseUrl/verify-email-otp'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'otp': otp}),
      );

      print('✅ Verify OTP Response: ${response.statusCode}');
      print('📥 Response Data: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final newToken = responseData['token'] as String;
        await SecureStorage.saveToken(newToken);
        return newToken;
      }
      throw parseErrorResponse(responseData);
    } catch (e) {
      throw parseErrorResponse({'message': e.toString()});
    }
  }

  Future<void> logout() async {
    await SecureStorage.deleteToken();
  }

  // Error parsing
  String parseErrorResponse(dynamic responseData) {
    if (responseData == null) return 'Operation failed';

    if (responseData['errors'] is Map) {
      final errors = responseData['errors'] as Map;
      return errors.values
          .expand((errorList) => errorList is List ? errorList : [])
          .join('\n');
    }

    return responseData['message']?.toString() ?? 'Operation failed';
  }
}
