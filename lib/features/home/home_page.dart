import 'package:flutter/material.dart';
import 'package:momobill/core/presentation/util/navigator.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        title: Text('MoMoBill'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                semanticLabel: 'search',
              ),
              onPressed: () {
                print('Search button');
              }),
          IconButton(
              icon: Icon(
                Icons.tune,
                semanticLabel: 'filter',
              ),
              onPressed: () {
                print('Filter button');
              })
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: RaisedButton(
          child: Text('To Login Page'),
          onPressed: () {
            Navigator.pushNamed(context, ROUTE_LOGIN);
          },
        ),
      ),
    );
  }
}
