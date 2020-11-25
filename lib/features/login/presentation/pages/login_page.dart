import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momobill/core/presentation/util/alert.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.motorcycle_outlined, color: Colors.white, size: 50),
                  Text(
                    'MoMoBill',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 80),
                  _UsernameInput(),
                  SizedBox(height: 16),
                  _PasswordInput(),
                  SizedBox(height: 40),
                  _ButtonBar(),
                ],
              ),
            ),
          ),
        ));
  }
}

class _UsernameInput extends StatelessWidget {
  final _usernameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (username) => BlocProvider.of<LoginBloc>(context)
              .add(LoginUsernameChanged(username)),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white)),
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.white60),
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
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white)),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white60),
              errorText: state.username.invalid ? 'invalid password' : null),
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
        return Row(
          children: [
            OutlineButton(
              padding: EdgeInsets.all(16),
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).accentColor),
              child: Text('Register',
                  style: TextStyle(color: Theme.of(context).accentColor)),
              onPressed: () {
                Navigator.pushNamed(context, ROUTE_TRIVIA);
              },
            ),
            SizedBox(width: 8),
            Expanded(
              child: RaisedButton(
                child: Text('Login'),
                padding: EdgeInsets.all(16),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context)
                      .add(const LoginSubmitted());
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
