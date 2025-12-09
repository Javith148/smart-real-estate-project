import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/CreateProvider.dart';

class Dummy extends StatelessWidget {
  const Dummy({super.key});

  @override
  Widget build(BuildContext context) {
    final username = context.watch<Createprovider>().username;
    return Scaffold(
      body:  Container(
      child: Text(username) ,
    ),
    );
  }
}
