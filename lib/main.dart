import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momobill/core/presentation/util/navigator.dart';
import 'package:momobill/features/authentication/bloc/authentication_bloc.dart';
import 'package:momobill/features/login/presentation/pages/login_page.dart';
import 'package:momobill/features/trivia/presentation/pages/number_trivia_page.dart';
import 'package:momobill/features/vehicle/add/presentation/pages/add_vehicle_page.dart';

import 'colors.dart';
import 'features/home/home_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      routes: {
        ROUTE_LOGIN: (context) => LoginPage(),
        ROUTE_HOME: (_) => HomePage(),
        ROUTE_TRIVIA: (context) => NumberTriviaPage(),
        ROUTE_ADD_VEHICLE: (_) => AddVehiclePage(),
      },
      theme: _kTheme,
      home: BlocProvider(
        create: (_) => sl<AuthenticationBloc>(),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}

final ThemeData _kTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: orange500,
    primaryColor: blue700,
  );
}


