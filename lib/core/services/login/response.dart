class LoginResponse {
  String? token;

  LoginResponse({
    this.token,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['access_token'] = token;

    return data;
  }
}
