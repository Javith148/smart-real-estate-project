import 'package:flutter/material.dart';
import 'package:real_esate_finder/ApiConfig.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Createprovider with ChangeNotifier {
  // private variable  declaration
  String _username = "";
  String _mailid = "";
  String _password = "";

  //private variable ahh get vachu access pannurom
  String get username => _username;
  String get mailid => _mailid;
  String get password => _password;

  //user type pannura data va vera page ui update pannurathu
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

  //private list ethu yathuku use pannurathuna
  //namma add to cart kudukura product ellam ethutha store agum
  final List<Map<String, dynamic>> _cartItems = [];

  //private lsit ahh get vachu access pannurom
  List<Map<String, dynamic>> get cartItems => _cartItems;

  //product cart add panna use aguthu
  void addToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
    print("product added");
    notifyListeners();
  }

  //product cart la iruthu remove panna use aguthu
  void removeFromCart(Map<String, dynamic> item) {
    _cartItems.removeWhere((x) => x["title"] == item["title"]);
    print("product removed");
    notifyListeners();
  }
// cart la iruka product ellam clear panna 
  void clearall() {
    _cartItems.clear();
    notifyListeners();
  }

  //cart la product iruka illaya check panna
  bool isInCart(Map<String, dynamic> item) {
    return _cartItems.any((x) => x["title"] == item["title"]);
  }


 String _address = "";

  String get address => _address;

  void setAddress(String value) {
    _address = value;
    notifyListeners();
  }


//

  List<Map<String, dynamic>> _propertyList = [];

  List<Map<String, dynamic>> get propertyList => _propertyList;

  Future<void> fetchProperties() async {
    try {
      var url = Uri.parse(ApiConfig.getApi('/api/property_details/'));
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _propertyList = List<Map<String, dynamic>>.from(data);
        notifyListeners(); // 🔥 முக்கியம்
      }
    } catch (e) {
      print("API Error: $e");
    }
  }
  
}



