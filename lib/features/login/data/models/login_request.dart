class LoginRequest {
  String username;
  String password;

  LoginRequest({this.username, this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
