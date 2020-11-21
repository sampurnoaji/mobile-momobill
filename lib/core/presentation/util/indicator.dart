import 'package:flutter/material.dart';

void showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    },
  );
}

void hideOpenDialog(BuildContext context) {
  Navigator.of(context).pop();
}

void successSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(message),
    ),
  );
}

void errorSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ),
  );
}
