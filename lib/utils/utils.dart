import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static showToast({
    required String message,
    Color bgColor = Colors.red,
    Color textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  static void showSnackBar(
      {required String message, required BuildContext context}) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(message, textAlign: TextAlign.center),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
