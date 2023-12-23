import '../services/auth/auth_service.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() => _instance;

  AuthRepository._internal();

  Future<List> login(String email, String password) async {
    final loginResponse = await AuthService().login(
      email,
      password,
    );
    final List response = loginResponse;
    if (response.isEmpty) {
      throw AuthRepositoryException('An unknown error occurred');
    }
    return response;
  }

  Future<String> register(
      String email, String password, String firstName, String lastName) async {
    final registerResponse = await AuthService().register(
      email,
      password,
      firstName,
      lastName,
    );
    final token = registerResponse;
    if (token.isEmpty) {
      throw AuthRepositoryException('An unknown error occurred');
    }
    return token;
  }

  Future<void> forgotPassword(String email) async {
    final registerResponse = await AuthService().forgotPassword(email);
    final hasError = !registerResponse;
    if (hasError) {
      throw AuthRepositoryException('An unknown error occurred');
    }
  }
}

class AuthRepositoryException implements Exception {
  final String message;

  AuthRepositoryException(this.message);

  @override
  String toString() {
    return message;
  }
}
