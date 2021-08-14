import 'package:flutter/cupertino.dart';

class UtilsProvider extends ChangeNotifier {
  bool _formLoading = false;

  bool get formLoading => this._formLoading;
  set formLoading (bool value){
    this._formLoading = value;
    notifyListeners();
  }
}