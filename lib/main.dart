import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:real_esate_finder/SplashScreen.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Createprovider()),
              ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Esate Finder',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: const SplashScreen())),
    );
  }
}
