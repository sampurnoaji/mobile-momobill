import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momobill/colors.dart';
import 'package:momobill/core/presentation/util/navigator.dart';
import 'package:momobill/features/home/home_page.dart';
import 'package:momobill/features/login/presentation/bloc/login_bloc.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _unfocusedColor = Colors.grey[600];
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {
        //Redraw so that the username label reflects the focus state
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        //Redraw so that the password label reflects the focus state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<LoginBloc>(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginSuccess) {
              return HomePage();
            }

            return Form(
              key: _formKey,
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
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              color: _usernameFocusNode.hasFocus
                                  ? Theme.of(context).accentColor
                                  : _unfocusedColor)),
                      focusNode: _usernameFocusNode,
                      controller: _usernameController,
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Username tidak boleh kosong'
                            : null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: _passwordFocusNode.hasFocus
                                ? Theme.of(context).accentColor
                                : _unfocusedColor),
                      ),
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      controller: _passwordController,
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Password tidak boleh kosong'
                            : null;
                      },
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _usernameController.clear();
                            _passwordController.clear();
                            Navigator.pushNamed(context, ROUTE_TRIVIA);
                          },
                          child: Text('To Trivia Page'),
                          shape: BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              login(context);
                            }
                          },
                          child: Text('LOGIN'),
                          elevation: 8,
                          shape: BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void login(BuildContext context) {
    BlocProvider.of<LoginBloc>(context)
        .add(Login(_usernameController.text, _passwordController.text));
  }
}
