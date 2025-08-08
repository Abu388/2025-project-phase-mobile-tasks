import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

import 'package:hello_app/core/utils/token_storage.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final loginUrl = Uri.parse(
      'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v2/auth/login',
    );

    final loginResponse = await client.post(
      loginUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    print("LOGIN STATUS: ${loginResponse.statusCode}");
    print("LOGIN BODY: ${loginResponse.body}");

    if (loginResponse.statusCode == 200 || loginResponse.statusCode == 201) {
      // Step 1: Get access token from login response
      final token = jsonDecode(loginResponse.body)['data']['access_token'];
        ////////////////////////////
        // ✅ Save token globally
      TokenStorage().saveToken(token);
      ////////////////////////////.
      ///
      
      // Step 2: Fetch user info using token
      final userResponse = await client.get(
        Uri.parse(
          'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v2/users/me',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (userResponse.statusCode == 200 || userResponse.statusCode == 201) {
        final userData = jsonDecode(
          userResponse.body,
        )['data']; // ✅ Fix: Get actual user data
        return UserModel.fromJson(userData);
      } else {
        throw Exception('Failed to fetch user info: ${userResponse.body}');
      }
    } else {
      throw Exception('Failed to login: ${loginResponse.body}');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final registerUrl = Uri.parse(
      'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v2/auth/register',
    );

    final response = await client.post(
      registerUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }
}
