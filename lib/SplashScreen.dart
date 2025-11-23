import 'package:flutter/material.dart';
import 'package:real_esate_finder/homepage.dart';
import 'package:real_esate_finder/loader.dart';

import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool("isLoggedIn") ?? false;

    await Future.delayed(const Duration(seconds: 2)); 

    if (loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loader()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Real Estate Finder",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
