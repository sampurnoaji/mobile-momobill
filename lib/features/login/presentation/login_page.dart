import 'package:flutter/material.dart';
import 'package:momobill/colors.dart';

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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Icon(Icons.motorcycle_outlined, color: kBrown900,),
                SizedBox(height: 16.0),
                Text(
                  'MoMoBill',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 120.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                    color: _usernameFocusNode.hasFocus
                        ? Theme.of(context).accentColor
                        : _unfocusedColor),
              ),
              focusNode: _usernameFocusNode,
              controller: _usernameController,
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
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
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                  child: Text('REGISTER'),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('LOGIN'),
                  elevation: 8,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}