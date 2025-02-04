import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const storage = FlutterSecureStorage();
  static const keyToken = 'auth_token';

  static Future<void> saveToken(String token) async {
    await storage.write(key: keyToken, value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: keyToken);
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: keyToken);
  }
}