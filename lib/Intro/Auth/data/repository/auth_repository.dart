import 'dart:convert';
import 'dart:io';
import 'package:cloozy/Intro/Auth/data/services/secure_storage.dart';
import 'package:cloozy/Brand/Core/helper/assets.dart';
import 'package:cloozy/Intro/Auth/data/models/login_model.dart';
import 'package:cloozy/Intro/Auth/data/models/register_model.dart';
import 'package:cloozy/Intro/Auth/data/models/roles_model.dart';
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
    } on SocketException catch (e) {
      print('❌ SocketException: $e');
      throw Exception('Please check your internet connection.');
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
        return RegisterResponse.fromJson(responseData);
      } else {
        throw parseErrorResponse(responseData);
      }
    } on SocketException catch (e) {
      print('❌ SocketException: $e');
      throw Exception('Please check your internet connection.');
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
    } on SocketException catch (e) {
      print('❌ SocketException: $e');
      throw Exception('Please check your internet connection.');
    } catch (e) {
      throw parseErrorResponse({'message': e.toString()});
    }
  }

  // Email verification
  Future<void> verifyEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/verify-email'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'email': email}),
      );

      print('✅ Verify Email Response: ${response.statusCode}');
      print('📥 Response Data: ${response.body}');
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint not found. Please check the URL.');
      } else {
        throw Exception('Failed to resend OTP: ${response.body}');
      }
    } on SocketException catch (e) {
      print('❌ SocketException: $e');
      throw Exception('Please check your internet connection.');
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error resending OTP: $e');
    }
  }

  // OTP verification
// Updated OTP verification method
  Future<String> verifyEmailOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/verify-email-otp'), // Verify correct endpoint
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'otp': otp,
        }),
      );

      print('✅ Verify OTP Response: ${response.statusCode}');
      print('📥 Response Data: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Extract token from nested data object
        final token = responseData['data']['token'] as String;

        // Save token to secure storage
        await SecureStorage.saveToken(token);
        print('🔑 Token saved successfully');

        // Return the token for potential immediate use
        return token;
      } else {
        throw parseErrorResponse(responseData);
      }
    } on SocketException catch (e) {
      print('❌ SocketException: $e');
      throw Exception('Please check your internet connection.');
    } catch (e) {
      print('❌ OTP Verification Error: $e');
      throw parseErrorResponse({'message': e.toString()});
    }
  }

  Future<void> logout() async {
    await SecureStorage.deleteToken();
  }

  // Error parsing
  String parseErrorResponse(dynamic responseData) {
    if (responseData == null) return 'Wrong peration';

    if (responseData['errors'] is Map) {
      final errors = responseData['errors'] as Map;
      return errors.values
          .expand((errorList) => errorList is List ? errorList : [])
          .join('\n');
    }

    return responseData['message']?.toString() ?? 'Wrong Operation';
  }
}
