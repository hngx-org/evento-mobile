import '../services/login/login_service.dart';

class LoginRepository {
  static final LoginRepository _instance = LoginRepository._internal();

  factory LoginRepository() => _instance;

  LoginRepository._internal();

  Future<String> getToken(String userName, String password) async {
    final loginResponse = await LoginService().login(
      userName,
      password,
    );
    final token = loginResponse;
    if (token.isEmpty) {
      throw LoginRepositoryException('An unknown error occurred');
    }
    return token;
  }
}

class LoginRepositoryException implements Exception {
  final String message;

  LoginRepositoryException(this.message);

  @override
  String toString() {
    return message;
  }
}
