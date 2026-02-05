import 'package:flutter/material.dart';

class PropertyDetails extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyDetails({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(width * 0.03),
            child: Stack(
              children: [
                Image.asset(
                  property['image'],
                  height: height * 0.5,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
