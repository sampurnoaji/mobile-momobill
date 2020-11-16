part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess(this.token);
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
