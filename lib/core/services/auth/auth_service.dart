import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart';
import 'response.dart';

class AuthService {
  Future<List> login(String email, String password) async {
    final requestUrl = Uri.https(Env.baseUrl, 'api/v1/login');

    final requestBody = jsonEncode({
      "email": email,
      "password": password,
    });

    final response = await http.post(requestUrl,
        body: requestBody, headers: {'Content-Type': 'application/json'});

    final responseBody = jsonDecode(response.body);
    final loginResponse = LoginResponse.fromJson(responseBody);

    final token = loginResponse.token ?? '';
    final userId = loginResponse.userId ?? '';
    final message = loginResponse.message ?? '';
    final success = loginResponse.success ?? false;

    if (!success) {
      throw AuthServiceException(message);
    }

    return token.isNotEmpty ? [userId, token, message] : [];
  }

  Future<String> register(
      String email, String password, String firstName, String lastName) async {
    final requestUrl = Uri.https(Env.baseUrl, 'api/v1/register');

    final requestBody = jsonEncode({
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName
    });

    final response = await http.post(requestUrl,
        body: requestBody, headers: {'Content-Type': 'application/json'});

    final responseBody = jsonDecode(response.body);
    final registerResponse = RegisterResponse.fromJson(responseBody);

    final success = registerResponse.success ?? false;
    final message = registerResponse.message ?? '';

    if (!success) {
      throw AuthServiceException(message);
    }
    return message;
  }
}

class AuthServiceException implements Exception {
  final String message;

  AuthServiceException(this.message);

  @override
  String toString() {
    return message;
  }
}
