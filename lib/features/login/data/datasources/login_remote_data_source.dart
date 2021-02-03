import 'dart:convert';
import 'dart:io';

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
    try {
      final response = await client.post(
        'replace with login API',
        headers: {"content-type": "application/json"},
        body: json.encode(request.toJson()),
      );

      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        return LoginResponse.fromJson(json.decode(response.body));
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } on SocketException {
      throw ConnectionException();
    }
  }
}
