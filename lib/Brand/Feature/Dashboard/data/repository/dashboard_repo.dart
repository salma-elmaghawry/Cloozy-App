import 'dart:async';
import 'dart:convert';
import 'package:cloozy/Brand/Feature/Dashboard/data/models/daily_sales_model.dart';
import 'package:cloozy/Brand/Feature/Dashboard/data/models/visitore_number_model.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/helper/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class DashboardRepo {
  final _logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
    ),
  );
  //DailySales
  Future<DailySalesModel> fetchDailySales(String token) async {
    try {
      final isValid = await SecureStorage.isValidToken();
      if (!isValid) {
        throw Exception('Invalid authentication token');
      }

      final url = Uri.parse("$baseUrl/brands/daily-sales");
      _logger.i('🌐 Request URL: $url');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10));

      _logger.d('📥 Status: ${response.statusCode}');
      _logger.d('📦 Body: ${response.body}');

      // Validate response format
      final contentType = response.headers['content-type'];
      if (contentType == null || !contentType.contains('application/json')) {
        throw Exception('Invalid server response format');
      }

      // Handle status codes
      if (token.isEmpty) {
        throw Exception('Authentication required');
      }
      if (response.statusCode == 200) {
        return DailySalesModel.fromJson(
          jsonDecode(response.body)['data'] as Map<String, dynamic>,
        );
      } else if (response.statusCode == 401) {
        throw Exception('Session expired - Please reauthenticate');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error. Please try again later');
      } else {
        final error = jsonDecode(response.body)['message'] as String?;
        throw Exception(error ?? 'Unknown error occurred');
      }
    } on TimeoutException {
      _logger.e('⏰ Request timed out');
      throw Exception('Connection timeout. Check your network');
    } on FormatException {
      _logger.e('📄 Invalid JSON format');
      throw Exception('Server returned invalid data format');
    } on http.ClientException catch (e) {
      _logger.e('📡 Network error: ${e.message}');
      throw Exception('Network connection failed');
    } catch (e) {
      _logger.e('❗ Unexpected error: $e');
      throw Exception('Failed to load data: ${e.toString()}');
    }
  }

  //Visitors numbers
  Future<VisiotoreNumsModel> fetchVisitorsNumbers(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/brands//views'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      _logger.d('📥 Status: ${response.statusCode}');
      _logger.d('📦 Body: ${response.body}');
      if (response.statusCode == 200) {
        return VisiotoreNumsModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else if (response.statusCode >= 500) {
        throw Exception('Server error. Please try again later');
      } else {
        final error = jsonDecode(response.body)['message'] as String?;
        throw Exception(error ?? 'Unknown error occurred');
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
