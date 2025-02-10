import 'dart:async';
import 'dart:convert';
import 'package:cloozy/Brand/Feature/Dashboard/data/models/daily_sales_model.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class DashboardRepo {
  final _logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
    ),
  );

  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<DailySalesModel> fetchDailySales(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/brands/daily-sales"),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      _logger.d('Response Status: ${response.statusCode}');
      _logger.d('Response Headers: ${response.headers}');
      _logger.d('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return DailySalesModel.fromJson(
          jsonDecode(response.body)['data'] as Map<String, dynamic>,
        );
      } else {
        final error = jsonDecode(response.body)['message'] as String?;
        throw Exception(error ?? 'Unknown error occurred');
      }
    } on http.ClientException catch (e) {
      _logger.e('Network error: ${e.message}');
      throw Exception('Check your internet connection');
    } catch (e) {
      _logger.e('Unexpected error: $e');
      throw Exception('Failed to load data: ${e.toString()}');
    }
  }
}
