import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sellersapp/src/providers/user_provider.dart';
import 'package:sellersapp/src/utils/get_firebase_data.dart';

///Send request to firebase to create, login users
class AuthenticationService extends ChangeNotifier{
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyC1en_lzkhByCFXC6Am13iYejq41rEw6YQ';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String _navigate = 'ok';

  String get Navigate => this._navigate;
  set Navigate(String value){
     this._navigate = value;
  }

  Future<String> createUser (String email, String password, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signUp',{
      'key': _firebaseToken,
    });
    final resp = await http.post(url, body: json.encode(authData));
    final decodedResp = json.decode(resp.body);

    if (decodedResp['idToken'] != null){
      await _storage.write(key: 'idToken', value: decodedResp['idToken'].toString());
      await _storage.write(key: 'userName', value: subStringMail(email));
      userProvider.user = subStringMail(email);
      return 'ok';
    }else {
      return decodedResp['error']['message'].toString();
    }
  }

  Future<String> loginUser (String email, String password, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword',{
      'key': _firebaseToken,
    });
    final resp = await http.post(url, body: json.encode(authData));
    final decodedResp = json.decode(resp.body);


    if (decodedResp['idToken'] != null){
      await _storage.write(key: 'idToken', value: decodedResp['idToken'].toString());
      await _storage.write(key: 'userName', value: subStringMail(email));
      userProvider.user = subStringMail(email);
      return 'ok';
    }else {
      return decodedResp['error']['message'].toString();
    }
  }

  Future logoutUser () async {
    await _storage.delete(key: 'idToken');
    await _storage.delete(key: 'userName');
  }

  Future<String> resetPassword (String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:sendOobCode', {
      'key': _firebaseToken,
    });
    final resp = await http.post(url, body: json.encode(authData));
    final decodedResp = json.decode(resp.body);

    if (decodedResp['idToken'] != null) {
      await _storage.write(
          key: 'idToken', value: decodedResp['idToken'].toString());
      return 'ok';
    } else {
      return decodedResp['error']['message'].toString();
    }
  }
  Future<List<String>> readToken () async {
    final String _idToken = await _storage.read(key: 'idToken') ?? '';
    final String _user = await _storage.read(key: 'userName') ?? '';
    final List<String> _list = [_idToken,_user];
    return _list;
  }
}