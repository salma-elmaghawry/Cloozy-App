import 'package:cloozy/Core/helper/assets.dart';
import 'package:cloozy/Feature/Auth/data/models/login_model.dart';
import 'package:cloozy/Feature/Auth/data/models/roles_model.dart';
import 'package:dio/dio.dart';
import 'package:cloozy/Feature/Auth/data/models/register_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final storage = const FlutterSecureStorage();

  // Save token to secure storage
  Future<void> saveToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {'Content-Type': 'application/json'},
    validateStatus: (status) => status! < 500,
  ));

//roles mothod
 Future<List<Role>> getRoles() async {
  try {
    final response = await _dio.get('/users/pre-register');
    print('✅ Received response: ${response.statusCode}');
    print('📥 Response Data: ${response.data}');

    if (response.statusCode == 200) {
      List rolesData = response.data['data']['roles'];
      return rolesData.map((json) => Role.fromJson(json)).toList(); // Fixed
    } else {
      throw Exception("Failed to fetch roles");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Error fetching roles");
  }
}


//register method
  Future<RegisterResponse> register(RegisterRequest data) async {
    try {
      print('⏳ Starting registration request...');
      print('📤 Request Data: ${data.toJson()}');
      final response = await _dio.post(
        '/users/register',
        data: data.toJson(),
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            // Add your token here
          },
        ),
      );
      final token = response.data['token'];
      await saveToken(token);
      print('✅ Received response: ${response.statusCode}');
      print('📥 Response Data: ${response.data}');
      if (response.data['message'] == 'User registered successfully.') {
        return RegisterResponse.fromJson(response.data);
      } else {
        throw parseErrorResponse(response.data);
      }
    } on DioException catch (e) {
      print('📡 Error Type: ${e.type}');
      print('💬 Error Message: ${e.message}');

      if (e.response != null) {
        print('🔴 Response Status: ${e.response?.statusCode}');
        print('📄 Response Data: ${e.response?.data}');
      } else {
        print('🌐 Network Error: ${e.error ?? 'No response from server'}');
      }

      String errorMessage = 'Registration failed';
      if (e.response?.data is Map<String, dynamic>) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      throw errorMessage;
    } catch (e) {
      print('❌ Unexpected Error: $e');
      throw ('$e');
    }
  }

//login method
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
        await storage.write(key: 'auth_token', value: loginResponse.token);
        return loginResponse;
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Login failed';
      throw Exception(errorMessage);
    }
  }
}

// Get current token
// Future<String?> getToken() async {
//   return await storage.read(key: 'auth_token');
// }

// // Clear token
// Future<void> logout() async {
//    await storage.delete(key: 'auth_token');
// }
String parseErrorResponse(dynamic responseData) {
  if (responseData == null) return 'Registration failed';

  // Handle multiple errors
  if (responseData['errors'] is Map) {
    final errors = responseData['errors'] as Map;
    return errors.values
        .expand((errorList) => errorList is List ? errorList : [])
        .join('\n');
  }

  // Handle single message
  return responseData['message']?.toString() ?? 'Registration failed';
}
