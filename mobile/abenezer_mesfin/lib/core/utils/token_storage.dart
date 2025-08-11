import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static final TokenStorage _instance = TokenStorage._internal();
  String? _token;

  factory TokenStorage() => _instance;

  TokenStorage._internal();

  /// Save token in memory + SharedPreferences
  Future<void> saveToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    print('Token saved ✅: $token');
  }

  /// Returns token from memory if available, otherwise loads from SharedPreferences
  static Future<String?> getToken() async {
    if (_instance._token != null) {
      return _instance._token;
    }
    final prefs = await SharedPreferences.getInstance();
    _instance._token = prefs.getString('auth_token');
    return _instance._token;
  }

  /// Extracts userId from token payload (JWT decode)
  String? get userId {
    if (_token == null) return null;
    final parts = _token!.split('.');
    if (parts.length != 3) return null;

    try {
      final payload = base64Url.normalize(parts[1]);
      final decoded =
          json.decode(utf8.decode(base64Url.decode(payload)));
      return decoded['id'] ??
          decoded['userId'] ??
          decoded['sub']; // many JWTs store userId as 'sub'
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }

  /// Clear token from memory and storage
  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    print('Token cleared ❌');
  }
}
