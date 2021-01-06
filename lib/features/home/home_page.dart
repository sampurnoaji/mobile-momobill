import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momobill/core/presentation/util/navigator.dart';
import 'package:momobill/features/authentication/bloc/authentication_bloc.dart';

import '../../injection_container.dart';

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
      body: buildBody(context)
    );
  }

  BlocProvider<AuthenticationBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(ROUTE_LOGIN, (Route<dynamic> route) => false);
              },
            ),
            SizedBox(height: 16),
            RaisedButton(
              child: Text('Add Vehicle'),
              onPressed: () {
                Navigator.of(context).pushNamed(ROUTE_ADD_VEHICLE);
              },
            )
          ],
        ),
      ),
    );
  }
}
