import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:sellersapp/src/auth/auth.dart';
import 'package:sellersapp/src/utils/login_messages.dart';
import 'package:sellersapp/src/utils/login_theme.dart';

///Login Page for sellers
class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Logiciel AppLab',
      logo: 'assets/login_icon.png',
      messages: loginMessages,
      onSignup: (data)=> AuthUser().signUp(data, context),
      onLogin: (data)=> AuthUser().signIn(data, context),
      onRecoverPassword: null,
      onSubmitAnimationCompleted: (){AuthUser().submit(context);},
      theme: loginTheme,
    );
  }

}
