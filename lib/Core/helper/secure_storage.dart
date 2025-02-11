import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyToken = 'auth_token';
  static const _keyTokenExpiry = 'token_expiry';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
    await _storage.write(
        key: _keyTokenExpiry,
        value: DateTime.now()
            .add(const Duration(hours: 2))
            .millisecondsSinceEpoch
            .toString());
  }
  static Future<bool> isValidToken() async {
  try {
    final expiry = await _storage.read(key: _keyTokenExpiry);
    final token = await _storage.read(key: _keyToken);
    
    if (token == null || expiry == null) return false;
    
    final expiryTime = int.tryParse(expiry) ?? 0;
    return DateTime.now().millisecondsSinceEpoch < expiryTime;
  } catch (e) {
    return false;
  }
}

  static Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }
}
