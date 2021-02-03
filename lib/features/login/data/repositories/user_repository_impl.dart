import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:momobill/core/error/exception.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/core/network/network_info.dart';
import 'package:momobill/features/login/data/datasources/login_remote_data_source.dart';
import 'package:momobill/features/login/data/models/login_request.dart';
import 'package:momobill/features/login/data/models/login_response.dart';
import 'package:momobill/features/login/domain/models/login_data.dart';
import 'package:momobill/features/login/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {@required this.loginRemoteDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, LoginData>> login(String username, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final loginResponse = await loginRemoteDataSource.login(LoginRequest(username: username, password: password));
        return Right(loginResponse.toDomainModel);
      } on ServerErrorException {
        return Left(ServerFailure());
      } on ClientErrorException {
        return Left(ClientFailure());
      } on UnknownException {
        return Left(UnknownFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<String> authenticate(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return 'token';
  }

  @override
  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 2));
    return false;
  }

  @override
  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  @override
  Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }
}
