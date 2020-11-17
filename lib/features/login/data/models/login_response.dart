
import 'package:momobill/features/login/domain/models/login_data.dart';

class LoginResponse {
  String token;

  LoginResponse({this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(token: json['token']);
  }
}

extension LoginExtension on LoginResponse {
  get toDomainModel {
    return LoginData(token: this.token);
  }
}