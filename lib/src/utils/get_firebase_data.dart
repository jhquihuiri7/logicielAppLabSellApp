import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellersapp/src/providers/user_provider.dart';
String date (){
  final int _year = DateTime.now().year;
  final String _month = _formatDate(DateTime.now().month.toString());
  final String _day = _formatDate(DateTime.now().day.toString());
  DateTime date = DateTime.parse('$_year-$_month-$_day 00:00:00.000');
  return date.millisecondsSinceEpoch.toString().substring(0,10);
}
String _formatDate(String date){
  if (date.length == 1){
    return '0$date';
  }else{
    return date;
  }
}
String subStringMail(String email){
  List<String> _lista = email.split("@");
  print(_lista[0]);
  return _lista[0];
}

List<String> estimatedEarnings(){
  final _monthDay = DateTime.now().day;
  final _now = int.parse(date());
  List<String> _dates = [];
  for (int i = _monthDay-1 ; i > 0 ; i--){
    _dates.add((_now - (i*86400)).toString());
  }
  _dates.add(date());
  return _dates;
}
class Prueba {
  int Index;
  int Counter;
  Prueba(this.Index, this.Counter);

}

Future calculateEarnings (BuildContext context) async{
  final userProvider = Provider.of<UserProvider>(context);
  final List<String> dates = estimatedEarnings();
  int estimatedEarningCount = 0;
  dates.forEach((element) async{
    final url = Uri.parse('https://logicielapplabwebpage-default-rtdb.firebaseio.com/$element/jho/list.json');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body) as List<dynamic>;
    if (decodedData != null){
      decodedData.forEach((element) {
        if (element['Form'] != null) {
          if (element['Form']['Compra'] == 'Sí'){
            estimatedEarningCount++;
          }
        }
      });
    }
    userProvider.estimatedEarning = estimatedEarningCount;
  }
  );

}