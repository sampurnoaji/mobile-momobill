import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:momobill/core/error/exception.dart';
import 'package:momobill/features/login/data/models/login_request.dart';
import 'package:momobill/features/login/data/models/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final Client client;

  LoginRemoteDataSourceImpl({@required this.client});

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await client.post(
      'replace with login API',
      headers: {"content-type": "application/json"},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
