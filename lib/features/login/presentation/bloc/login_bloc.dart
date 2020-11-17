import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/features/login/data/models/password.dart';
import 'package:momobill/features/login/data/models/username.dart';
import 'package:momobill/features/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({@required LoginUseCase loginUseCase})
      : assert(loginUseCase != null),
        this.loginUseCase = loginUseCase,
        super(const LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield LoginLoading();
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        final result = await loginUseCase(Params(
            username: state.username.value, password: state.password.value));
        yield result.fold(
            (l) => LoginFailure(message: _mapFailureToMessage(l)),
            (r) => LoginSuccess());
        yield state.copyWith(status: FormzStatus.submissionFailure);
      } on Exception catch (_) {
        yield LoginFailure(message: UNKNOWN_FAILURE_MESSAGE);
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
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
