
import 'package:flutter/material.dart';
import 'package:momobill/core/network/api/api_base_helper.dart';
import 'package:momobill/features/login/data/models/login_request.dart';
import 'package:momobill/features/login/data/models/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final ApiBaseHelper helper;

  LoginRemoteDataSourceImpl({@required this.helper});

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await helper.post('/api/v1/login', request.toJson());
    // final response = await helper.postMock('/api/v1/login', request, 'assets/login_response.json');
    return LoginResponse.fromJson(response);
  }
}
