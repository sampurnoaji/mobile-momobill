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
  final _usernameInputFocusNode = FocusNode();
  final _passwordInputFocusNode = FocusNode();
  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showLoadingIndicator(context);
          } else if (state is LoginFailure) {
            hideOpenDialog(context);
            errorSnackBar(context, state.message);
          } else if (state is LoginSuccess) {
            hideOpenDialog(context);
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
                  Icon(Icons.motorcycle_outlined,
                      color: Colors.white, size: 50),
                  Text(
                    'MoMoBill',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 80),
                  // _UsernameInput(),
                  TextFormField(
                    onChanged: (username) => _username = username,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white60)),
                    focusNode: _usernameInputFocusNode,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    onChanged: (password) => _password = password,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white60)),
                    focusNode: _passwordInputFocusNode,
                    obscureText: true,
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      OutlineButton(
                        padding: EdgeInsets.all(16),
                        borderSide: BorderSide(
                            width: 1, color: Theme.of(context).accentColor),
                        child: Text('Register',
                            style: TextStyle(
                                color: Theme.of(context).accentColor)),
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
                                .add(LoginSubmitted(_username, _password));
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
