import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:real_esate_finder/main_login.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:geocoding/geocoding.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<void> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        double lat = locations.first.latitude;
        double lng = locations.first.longitude;

        debugPrint("LAT: $lat");
        debugPrint("LNG: $lng");
      }
    } catch (e) {
      debugPrint("Error getting lat/lng: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<Createprovider>().address;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFF1F4C6B),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: Consumer<Createprovider>(
        builder: (context, provider, child) {
          return Center(
            child: Column(
              children: [
                Text(
                  address.isEmpty ? "No address selected" : address,
                  style: TextStyle(fontSize: 16),
                ),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
