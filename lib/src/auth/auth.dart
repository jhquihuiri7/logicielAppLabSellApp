import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/providers/firebase_auth.dart';
import 'package:sellersapp/src/providers/user_provider.dart';
///AuthUser allow to navigate to pages in LoginPage
class AuthUser {

  Future<String> signUp(LoginData data, BuildContext context) async {
    final authService = Provider.of<AuthenticationService>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.user = data.name.toString();
    final String resp = await authService.createUser(data.name, data.password, context);
    authService.Navigate = resp;
  }

  Future<String> signIn(LoginData data, BuildContext context) async {
    final authService = Provider.of<AuthenticationService>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.user = data.name.toString();
    final String resp = await authService.loginUser(data.name, data.password, context);
    authService.Navigate = resp;
  }

  void submit(BuildContext context){
    final authService = Provider.of<AuthenticationService>(context, listen: false);
    if (authService.Navigate == 'ok'){
      Navigator.pushNamed(context, 'main');
    }else{
      Navigator.pushNamed(context, 'login');
      final snackBar = SnackBar(content: Text(authService.Navigate));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}