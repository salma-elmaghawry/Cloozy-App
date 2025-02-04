import 'package:cloozy/Core/helper/assets.dart';
import 'package:cloozy/Core/helper/secure_storage.dart';
import 'package:cloozy/Feature/Auth/data/models/login_model.dart';
import 'package:cloozy/Feature/Auth/data/models/register_model.dart';
import 'package:cloozy/Feature/Auth/data/models/roles_model.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {'Content-Type': 'application/json'},
    validateStatus: (status) => status! < 500,
  ));

  // Roles method
  Future<List<Role>> getRoles() async {
    try {
      final response = await _dio.get('/users/pre-register');
      print('✅ Received response: ${response.statusCode}');
      print('📥 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        List rolesData = response.data['data']['roles'];
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

      final response = await _dio.post(
        '/users/register',
        data: data.toJson(),
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );

      print('✅ Received response: ${response.statusCode}');
      print('📥 Response Data: ${response.data}');

      if (response.statusCode == 200 && 
          response.data['message'] == 'User registered successfully.') {
        final token = response.data['data']['token'] as String;
        await SecureStorage.saveToken(token);
        return RegisterResponse.fromJson(response.data);
      } else {
        throw parseErrorResponse(response.data);
      }
    } on DioException catch (e) {
      print('🚨 Dio Error Occurred');
      print('📡 Error Type: ${e.type}');
      print('💬 Error Message: ${e.message}');

      if (e.response != null) {
        print('🔴 Response Status: ${e.response?.statusCode}');
        print('📄 Response Data: ${e.response?.data}');
      }
      throw parseErrorResponse(e.response?.data);
    } catch (e) {
      print('❌ Unexpected Error: $e');
      throw parseErrorResponse({'message': e.toString()});
    }
  }

  // Login method
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/users/login',
        data: request.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);
        await SecureStorage.saveToken(loginResponse.token);
        return loginResponse;
      } else {
        throw parseErrorResponse(response.data);
      }
    } on DioException catch (e) {
      throw parseErrorResponse(e.response?.data);
    }
  }

  // Email verification
  Future<void> verifyEmail(String email) async {
    try {
      final response = await _dio.post(
        '/verify-email',
        data: {'email': email},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      print('✅ Verify Email Response: ${response.statusCode}');
      print('📥 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return;
      }
      throw parseErrorResponse(response.data);
    } on DioException catch (e) {
      throw parseErrorResponse(e.response?.data);
    }
  }

  // OTP verification
  Future<String> verifyEmailOtp(String otp) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) throw Exception('Authentication required');

      final response = await _dio.post(
        '/verify-email-otp',
        data: {'otp': otp},
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );

      print('✅ Verify OTP Response: ${response.statusCode}');
      print('📥 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final newToken = response.data['token'] as String;
        await SecureStorage.saveToken(newToken);
        return newToken;
      }
      throw parseErrorResponse(response.data);
    } on DioException catch (e) {
      throw parseErrorResponse(e.response?.data);
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

  // Logout
}