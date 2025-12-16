import 'package:flutter/material.dart';
import 'package:real_esate_finder/homepage.dart';
import 'package:real_esate_finder/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/CreateProvider.dart';

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
    String savedUsername = prefs.getString("name") ?? "";

    await Future.delayed(const Duration(seconds: 2));

    if (loggedIn) {
   
      if (savedUsername.isNotEmpty) {
        final provider = Provider.of<Createprovider>(context, listen: false);
        provider.setUsername(savedUsername);
      }
      print("Username from SharedPref: $savedUsername");


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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final prov = Provider.of<Createprovider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ---------- CENTER CONTENT ----------
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Image.asset(
                  "assets/logo.png", // <-- Unnoda logo path
                  width: width * 0.35,
                ),

                SizedBox(height: height * 0.03),

                // Circular Loader
                CircularProgressIndicator(
                  color: Colors.blueAccent,
                  strokeWidth: 3,
                ),

                Text(prov.username),
              ],
            ),
          ),

          // ---------- VERSION TEXT AT BOTTOM ----------
          Positioned(
            bottom: height * 0.04,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
