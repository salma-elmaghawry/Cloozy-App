import 'package:dio/dio.dart';
import 'package:cloozy/Feature/Auth/manager/models/register_model.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://cloozy.azurewebsites.net/api",
    headers: {'Content-Type': 'application/json'},
    validateStatus: (status) => status! < 500,
  ));

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
//status code and response data
      print('✅ Received response: ${response.statusCode}');
      print('📥 Response Data: ${response.data}');
      // Handle redirects
      if (response.statusCode == 302 || response.statusCode == 301) {
        print('⚠️ Redirect detected');
        throw Exception('Server redirected - Check API endpoint configuration');
      }
      // Handle HTML responses
      if (response.data is String &&
          response.data.contains('<!DOCTYPE html>')) {
        print('⚠️ HTML response detected');
        throw Exception('Received HTML response instead of JSON');
      }

      // Handle successful response
      if (response.statusCode == 200) {
        print('🎉 Registration successful');
        return RegisterResponse.fromJson(response.data);
      }

      // Handle validation errors (422)
      if (response.statusCode == 422) {
        final errors = response.data['errors'] as Map<String, dynamic>?;
        final errorMessage =
            StringBuffer(response.data['message'] ?? 'Validation failed');

        errors?.forEach((field, messages) {
          errorMessage.write('\n• $field: ${(messages as List).join(', ')}');
        });

        print('❌ Validation errors: $errorMessage');
        throw Exception(errorMessage.toString());
      }

      // Handle other error status codes
      final errorMessage = response.data['message'] ??
          'Registration failed with status ${response.statusCode}';
      print('❌ Server error: $errorMessage');
      throw Exception(errorMessage);
    } on DioException catch (e) {
      print('🚨 Dio Error Occurred');
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
      throw Exception(errorMessage);
    } catch (e) {
      print('❌ Unexpected Error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}
