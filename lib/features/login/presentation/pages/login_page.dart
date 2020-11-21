import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:momobill/colors.dart';
import 'package:momobill/core/presentation/util/indicator.dart';
import 'package:momobill/core/presentation/util/navigator.dart';
import 'package:momobill/features/login/presentation/bloc/login_bloc.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(create: (_) => sl<LoginBloc>(), child: LoginForm()),
    );
  }
}

class LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          // showLoadingIndicator(context);
          Navigator.pushReplacementNamed(context, ROUTE_HOME);
        } else if (state is LoginFailure) {
          hideOpenDialog(context);
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message)),
            );
        } else if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, ROUTE_HOME);
        }
      },
      child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.motorcycle_outlined,
                      color: kBrown900,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'MoMoBill',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                SizedBox(height: 120.0),
                _UsernameInput(),
                SizedBox(height: 16),
                _PasswordInput(),
                _ButtonBar(),
              ],
            ),
          )),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final _usernameFocusNode = FocusNode();
  final _unfocusedColor = Colors.grey[600];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (username) => BlocProvider.of<LoginBloc>(context)
              .add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(
                  color: _usernameFocusNode.hasFocus
                      ? Theme.of(context).accentColor
                      : _unfocusedColor),
              errorText: state.username.invalid ? 'invalid username' : null),
          focusNode: _usernameFocusNode,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final _passwordFocusNode = FocusNode();
  final _unfocusedColor = Colors.grey[600];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (password) => BlocProvider.of<LoginBloc>(context)
              .add(LoginPasswordChanged(password)),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
                color: _passwordFocusNode.hasFocus
                    ? Theme.of(context).accentColor
                    : _unfocusedColor),
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
          focusNode: _passwordFocusNode,
          obscureText: true,
        );
      },
    );
  }
}

class _ButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ButtonBar(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, ROUTE_TRIVIA);
              },
              child: Text('To Trivia Page'),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
            ),
            RaisedButton(
              onPressed: state.status.isValidated
                  ? () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(const LoginSubmitted());
                    }
                  : null,
              child: Text('LOGIN'),
              elevation: 8,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
            )
          ],
        );
      },
    );
  }
}
