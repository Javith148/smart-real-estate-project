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

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
    print("prodect added");
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> item) {
    _cartItems.removeWhere((x) => x["title"] == item["title"]);
    print("product removed");
    notifyListeners();
  }

  bool isInCart(Map<String, dynamic> item) {
    return _cartItems.any((x) => x["title"] == item["title"]);
  }
}
