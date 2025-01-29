import 'package:dio/dio.dart';
import 'package:cloozy/Features/Auth/manager/models/register_model.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://cloozy.azurewebsites.net/api",
    headers: {'Content-Type': 'application/json'},
  ));

  Future<RegisterResponse> register(RegisterRequest data) async {
    try {
      final response = await _dio.post(
        '/users/register',
        data: data.toJson(),
      );
      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Failed to register: ${e.response?.data['message'] ?? e.message}',
      );
    }
  }
}