class LoginService {
  Future<String> login(String username, String password) async {
    return '';
  }
}

class LoginServiceException implements Exception {
  final String message;

  LoginServiceException(this.message);

  @override
  String toString() {
    return message;
  }
}
