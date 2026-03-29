import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/Provider/CreateProvider.dart';
import 'package:real_esate_finder/screens/SplashScreen/SplashScreen.dart';






void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Createprovider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
void initState() {
  super.initState();
  Future.microtask(() =>
    Provider.of<Createprovider>(context, listen: false)
        .fetchProperties()
  );
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Esate Finder',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: const SplashScreen()),
      ),
    );
  }
}
