import 'package:flutter_login/flutter_login.dart';
import 'package:flutter/material.dart';

LoginTheme _loginTheme = LoginTheme(
  primaryColor: const Color(0xff55408a),
  buttonTheme: const LoginButtonTheme(
    splashColor: Color(0xff0e1d22),
    backgroundColor: Color(0xff0e1d22),
    highlightColor: Color(0xff5d85b1),
    elevation: 9.0,
    highlightElevation: 6.0,
  ),
  
);

LoginTheme get loginTheme => _loginTheme;