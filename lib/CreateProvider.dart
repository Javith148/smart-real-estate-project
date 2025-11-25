import 'package:flutter/material.dart';

class Createprovider with ChangeNotifier {
  String _username = "";
  String _mailid = "";
  String _password = "";

  String get username => _username;
  String get mailid => _mailid;
  String get password => _password;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setMailid(String value) {
    _mailid = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }
}
