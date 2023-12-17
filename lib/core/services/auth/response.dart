class LoginResponse {
  String? token;
  String? message;
  bool? success;
  Map<String, dynamic>? data;
  String? userId;

  LoginResponse(
      {this.token, this.message, this.success, this.data, this.userId});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = json['data'];
    token = data?['token'];
    userId = data?['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['token'] = token;
    data['message'] = message;
    data['success'] = success;
    data['data'] = data;
    data['userId'] = userId;
    return data;
  }
}

class RegisterResponse {
  String? message;
  String? timestamp;
  bool? success;
  int? status;
  Map<String, dynamic>? data;

  RegisterResponse({
    this.data,
    this.timestamp,
    this.status,
    this.success,
    this.message,
  });

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    timestamp = json['timestamp'];
    success = json['success'];
    data = json['data'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['timestamp'] = timestamp;
    data['success'] = success;
    data['data'] = data;
    data['status'] = status;

    return data;
  }
}
