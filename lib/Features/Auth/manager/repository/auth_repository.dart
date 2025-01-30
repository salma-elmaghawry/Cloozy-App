import 'package:dio/dio.dart';
import 'package:cloozy/Features/Auth/manager/models/register_model.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://cloozy.azurewebsites.net/api",
    headers: {'Content-Type': 'application/json'},
    followRedirects: false,
    validateStatus: (status) => status! < 500,
  ));

  Future<RegisterResponse> register(RegisterRequest data) async {
    try {
      final response = await _dio.post(
        '/users/register',
        data: data.toJson(),
        options: Options(validateStatus: (status) => true),
      );
      if (response.statusCode == 302 || response.statusCode == 301) {
        throw Exception('Server redirected - Check API endpoint configuration');
      }

      if (response.data is String &&
          response.data.contains('<!DOCTYPE html>')) {
        throw Exception('Received HTML response instead of JSON');
      }
      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('Error Response: ${e.response?.data}');
      final errorData = e.response?.data;
      String errorMessage = 'Registration failed';

      if (errorData is Map<String, dynamic>) {
        errorMessage = errorData['message'] ?? 'Unknown error';
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (errorData != null) {
        errorMessage = 'Unexpected error format: ${errorData.runtimeType}';
      }

      throw Exception(errorMessage);
    }
  }
}
