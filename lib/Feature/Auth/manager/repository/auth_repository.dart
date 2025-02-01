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
      print('✅ Received response: ${response.statusCode}');
      print('📥 Response Data: ${response.data}');
      if (response.data['message'] == 'User registered successfully.') {
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
}
