import 'package:flutter/material.dart';
import 'package:momobill/core/presentation/util/navigator.dart';
import 'package:momobill/features/login/presentation/login_page.dart';
import 'package:momobill/features/trivia/presentation/pages/number_trivia_page.dart';

import 'colors.dart';
import 'features/home/home_page.dart';
import 'injection_container.dart' as di;

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
      home: HomePage(),
      routes: {
        ROUTE_LOGIN: (context) => LoginPage(),
        ROUTE_TRIVIA: (context) => NumberTriviaPage()
      },
      theme: _kTheme,
    );
  }
}

final ThemeData _kTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kBrown900,
    primaryColor: kPink100,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kPink100,
      colorScheme: base.colorScheme.copyWith(
        secondary: kBrown900,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: kBackgroundWhite,
    cardColor: kBackgroundWhite,
    textSelectionColor: kPink100,
    errorColor: kErrorRed,
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(
        color: kBrown900
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: kBrown900,
        ),
      ),
      border: OutlineInputBorder(),
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    headline5: base.headline5.copyWith(
      fontWeight: FontWeight.w500,
    ),
    headline6: base.headline6.copyWith(
        fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    bodyText1: base.bodyText1.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: kBrown900,
    bodyColor: kBrown900,
  );
}

