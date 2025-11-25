import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:real_esate_finder/main_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Logout Function
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Removing saved login/session details

    // Go to Login Page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Read Username from Provider
   final name = context.watch<Createprovider>().username;
   final mail = context.watch<Createprovider>().mailid;
   final pass = context.watch<Createprovider>().password;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: 
      Column(
        children: [
          Text(name),
          Text(mail),
          Text(pass)
        ],
      )
    );
  }
}
