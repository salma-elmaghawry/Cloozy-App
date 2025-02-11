import 'dart:convert';
import 'dart:io';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Intro/Auth/data/models/login_model.dart';
import 'package:cloozy/Intro/Auth/data/models/register_model.dart';
import 'package:cloozy/Intro/Auth/data/models/roles_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  static const headers = {'Content-Type': 'application/json'};
  final _logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
    ),
  );
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Helper method for making HTTP requests
  Future<Map<String, dynamic>> _makeRequest(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      _logger.d('✅ Response: ${response.statusCode}');
      _logger.d('📥 Response Data: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw parseErrorResponse(responseData);
      }
    } on SocketException catch (e) {
      _logger.e('❌ SocketException: $e');
      throw Exception('Please check your internet connection.');
    } catch (e) {
      _logger.e('❌ Error: $e');
      throw parseErrorResponse({'message': e.toString()});
    }
  }

  // Roles method
  Future<List<Role>> getRoles() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/pre-register'),
        headers: headers,
      );

      _logger.d('✅ Received response: ${response.statusCode}');
      _logger.d('📥 Response Data: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        List rolesData = responseData['data']['roles'];
        return rolesData.map<Role>((json) => Role.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch roles");
      }
    } on SocketException catch (e) {
      _logger.e('❌ SocketException: $e');
      throw Exception('Please check your internet connection.');
    } catch (e) {
      _logger.e("Error: $e");
      throw Exception("Error fetching roles");
    }
  }

  // Registration method
  Future<RegisterResponse> register(RegisterRequest data) async {
    _logger.d('⏳ Starting registration request...');
    _logger.d('📤 Request Data: ${data.toJson()}');

    final responseData = await _makeRequest('users/register', data.toJson());

    if (responseData['message'] == 'User registered successfully.') {
      return RegisterResponse.fromJson(responseData);
    } else {
      throw parseErrorResponse(responseData);
    }
  }

  // Login method
  Future<LoginResponse> login(LoginRequest request) async {
    final responseData = await _makeRequest('users/login', request.toJson());

    final loginResponse = LoginResponse.fromJson(responseData);
    await _secureStorage.write(key: 'auth_token', value: loginResponse.token);
    return loginResponse;
  }

  // Account recovery (forget password)
  Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    return _makeRequest('users/account-recovery', {'email': email});
  }

  // Account recovery (forget password OTP to reset password)
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String newPassword,
    required String newPasswordConfirmation,
    required String otp,
  }) async {
    return _makeRequest('users/account-recovery-otp', {
      'email': email,
      'otp': otp,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    });
  }

  // Email verification
  Future<void> verifyEmail(String email) async {
    await _makeRequest('users/verify-email', {'email': email});
  }

  // Verify email OTP
  Future<String> verifyEmailOtp(String email, String otp) async {
    final responseData = await _makeRequest('users/verify-email-otp', {
      'email': email,
      'otp': otp,
    });

    final token = responseData['data']['token'] as String;
    await _secureStorage.write(key: 'auth_token', value: token);
    return token;
  }

  // Logout
  Future<void> logout() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  // Error parsing
  String parseErrorResponse(dynamic responseData) {
    if (responseData == null) return 'An unexpected error occurred.';

    if (responseData['errors'] is Map) {
      final errors = responseData['errors'] as Map;
      return errors.values
          .expand((errorList) => errorList is List ? errorList : [])
          .join('\n');
    }

    return responseData['message']?.toString() ??
        'An unexpected error occurred.';
  }
}
