import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(null);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield LoginLoading();
    await Future.delayed(Duration(seconds: 1));
    yield LoginSuccess('123456789');
  }
}
