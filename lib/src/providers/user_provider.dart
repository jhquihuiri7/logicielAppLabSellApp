import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sellersapp/src/models/user_model.dart';
import 'package:sellersapp/src/utils/get_firebase_data.dart';
///
class UserProvider extends ChangeNotifier {
  List _chartData = [];
  int _estimatedEarning = 0;
  String _userImg = '';
  String _user = '';
  final String _baseUrl = 'https://logicielapplabwebpage-default-rtdb.firebaseio.com';
  List<Task> _tasks = [];

  List get chartData => _chartData;
  set chartData (List value){
    _chartData = value;
    notifyListeners();
  }

  int get estimatedEarning => _estimatedEarning;
  set estimatedEarning (int value){
    this._estimatedEarning = value;
    notifyListeners();
  }

  String get userImg => _userImg;
  set userImg (String value){
    _userImg = value;
  }

  String get user => _user;
  set user (String value){
    _user = value;
  }
  List<Task> get tasks => _tasks;
  set tasks (List<Task> value){
    _tasks = value;
    notifyListeners();
  }


  Future<List<Task>> loadProducts () async {
    final dateRequest = date();
    final url = Uri.parse('https://logicielapplabwebpage-default-rtdb.firebaseio.com/$dateRequest/${_user}/list.json');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body) as List;
    List taskUser = decodedData;
    final Tasks tasks = Tasks();
    return tasks.generateTask(taskUser);
  }
  Future<Map<String, dynamic>> readUser (String user) async{
    final url = Uri.parse('https://logicielapplabwebpage-default-rtdb.firebaseio.com/users.json');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    return decodedData['jho'] as Map<String, dynamic>;
  }

}