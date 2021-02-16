import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/features/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({this.loginUseCase}) : super(null);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield LoginLoading();
      if (event.username == null ||
          event.username.isEmpty ||
          event.password == null ||
          event.password.isEmpty) {
        yield LoginFailure(message: 'Lengkapi Username/Password');
      } else {
        yield* _mapLoginSubmittedToState(event);
      }
    }
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
  ) async* {
      try {
        final result = await loginUseCase(
            Params(username: event.username, password: event.password));
        yield result.fold(
          (l) => LoginFailure(message: _mapFailureToMessage(l)),
          (r) => LoginSuccess(),
        );
      } on Exception catch (e) {
        yield LoginFailure(message: e.toString());
      }
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case ConnectionFailure:
        return CONNECTION_FAILURE_MESSAGE;
      default:
        return UNKNOWN_FAILURE_MESSAGE;
    }
  }
}
