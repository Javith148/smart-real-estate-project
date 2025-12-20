import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapWithAddress extends StatefulWidget {
  const MapWithAddress({super.key});

  @override
  State<MapWithAddress> createState() => _MapWithAddressState();
}

class _MapWithAddressState extends State<MapWithAddress> {
  GoogleMapController? mapController;

  LatLng selectedLocation = const LatLng(11.0168, 76.9558);

  String street = "";
  String city = "";

  // -------- REVERSE GEOCODING --------
  Future<void> getAddress(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String foundStreet = "";
      String foundCity = "";

      for (final place in placemarks) {
        if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty) {
          foundStreet = place.thoroughfare!;
          foundCity = place.locality ?? "";
          break;
        }
      }

      if (foundStreet.isEmpty && placemarks.isNotEmpty) {
        final place = placemarks.first;
        foundStreet = place.subLocality ?? "Street not available";
        foundCity = place.locality ?? "";
      }

      setState(() {
        street = foundStreet;
        city = foundCity;
      });
    } catch (e) {
      debugPrint("Geocoding error: $e");
    }
  }

  // -------- CURRENT LOCATION --------
Future<void> goToCurrentLocation() async {
  try {
    // 🔹 LOCATION SERVICE CHECK
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please turn on your location"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final currentLatLng =
        LatLng(position.latitude, position.longitude);

    setState(() {
      selectedLocation = currentLatLng;
    });

    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(currentLatLng, 16),
    );

    await getAddress(currentLatLng);
  } catch (e) {
    debugPrint("Location error: $e");
  }
}

 
  @override
  void initState() {
    super.initState();
    getAddress(selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          "Choose Location",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.045,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF1F4C6B),
      ),

      body: Stack(
        children: [
          // 🔹 MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLocation,
              zoom: 15,
            ),
           myLocationEnabled: false,

            myLocationButtonEnabled: false,
            onMapCreated: (controller) {
              mapController = controller;
            },
            onTap: (LatLng position) {
              setState(() {
                selectedLocation = position;
              });
              getAddress(position);
            },
            markers: {
              Marker(
                markerId: const MarkerId("selected"),
                position: selectedLocation,
              ),
            },
          ),

          // 🔹 FULL WIDTH ADDRESS CARD (NO LEFT / RIGHT GAP)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.06,
                vertical: height * 0.025,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(width * 0.06),
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 18,
                    color: Colors.black26,
                    offset: Offset(0, -6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: const Color(0xFF1F4C6B),
                        size: width * 0.06,
                      ),
                      SizedBox(width: width * 0.02),
                      Text(
                        "Selected Address",
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F4C6B),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.015),

                  Text(
                    street,
                    style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: height * 0.005),

                  Text(
                    city,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // 🔹 CONFIRM BUTTON (WHITE TEXT + ICON)
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.065,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F4C6B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                        ),
                      ),
                      icon: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                      ),
                      label: Text(
                        "CONFIRM LOCATION",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: width * 0.04,
                          letterSpacing: 0.6,
                        ),
                      ),
                      onPressed: () {
                        if (street.isNotEmpty) {
                          Navigator.pop(
                            context,
                            "$street, $city", // 👈 return value
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 CURRENT LOCATION BUTTON
          Positioned(
            right: width * 0.05,
            bottom: height * 0.14,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF1F4C6B),
              onPressed: goToCurrentLocation,
              child: Icon(
                Icons.my_location,
                color: Colors.white,
                size: width * 0.065,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
