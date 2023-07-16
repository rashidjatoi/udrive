import 'package:flutter/material.dart';
import 'package:udrive/screens/login_screen.dart';

import 'services_constants.dart';

abstract class AuthServices {
  static void registerUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await ServicesConstants.auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then(
          (value) => Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.id, (route) => false),
        )
        .then((value) => debugPrint(value.toString()));
  }
}
