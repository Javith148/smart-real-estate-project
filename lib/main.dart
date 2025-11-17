import 'package:flutter/material.dart';
import 'package:real_esate_finder/loader.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Real Esate Finder',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: HomePage()),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Loader();
  }
}