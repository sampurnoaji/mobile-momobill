import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/core/usecase/usecase.dart';
import 'package:momobill/features/login/domain/models/login_data.dart';
import 'package:momobill/features/login/domain/repositories/user_repository.dart';

class LoginUseCase implements UseCase<LoginData, Params> {
  final UserRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, LoginData>> call(Params params) async {
    return await repository.login(params.username, params.password);
  }
}

class Params extends Equatable {
  final String username;
  final String password;

  Params({@required this.username, @required this.password});

  @override
  List<Object> get props => [];
}