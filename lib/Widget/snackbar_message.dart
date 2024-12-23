import 'package:flutter/material.dart';

//Function for customize display snackBar Message
void showSnackBarMessage({
  required BuildContext context,
  required String errorMessage,
  required int duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        errorMessage,
        textDirection: TextDirection.rtl,
      ),
      duration: Duration(seconds: duration),
    ),
  );
}
