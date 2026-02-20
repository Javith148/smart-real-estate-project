import 'package:flutter/material.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PropertyDetails extends StatefulWidget {
  final Map<String, dynamic> property;

  const PropertyDetails({super.key, required this.property});

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  bool isAdded = false;
  bool? buyOrRent;
  late Future<List<Map<String, dynamic>>> nearbyFuture;
  double? straightDistance;

  LatLng? propertyLatLng; // from latlong2
  LatLng? destinationLatLng;

  List<LatLng> routePoints = [];
  bool showRoute = false;

  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  String? selectedPlaceType;
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    nearbyFuture = fetchNearbyFacilities(widget.property["location"]);
  }

  Future<Map<String, double>?> getLatLngFromAddress(String address) async {
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$address&format=json&limit=1",
    );

    final response = await http.get(
      url,
      headers: {"User-Agent": "real_estate_app"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty) {
        return {
          "lat": double.parse(data[0]["lat"]),
          "lng": double.parse(data[0]["lon"]),
        };
      }
    }
    return null;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // earth radius in km
    final dLat = (lat2 - lat1) * (pi / 180);
    final dLon = (lon2 - lon1) * (pi / 180);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180)) *
            cos(lat2 * (pi / 180)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }

  Future<List<Map<String, dynamic>>> getNearbyPlaces(
    double lat,
    double lng,
  ) async {
    List<Map<String, dynamic>> finalResults = [];
    List<String> amenities = ["hospital", "school", "fuel"];

    for (String amenity in amenities) {
      String query =
          """
    [out:json];
    node["amenity"="$amenity"](around:5000,$lat,$lng);
    out body;
    """;

      final url = Uri.parse("https://overpass-api.de/api/interpreter");

      final response = await http.post(url, body: {"data": query});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Map<String, dynamic>> results = [];

        for (var element in data["elements"]) {
          String? name = element["tags"]?["name"];
          double? placeLat = element["lat"];
          double? placeLng = element["lon"];

          if (name != null &&
              name.trim().isNotEmpty &&
              placeLat != null &&
              placeLng != null) {
            double distance = calculateDistance(lat, lng, placeLat, placeLng);

            results.add({
              "name": name.trim(),
              "lat": placeLat,
              "lng": placeLng,
              "distance": distance,
              "type": amenity,
            });
          }
        }

        for (var r in results) {
          if (r['distance'] <= 5.0) {
            finalResults.add(r);
          }
        }
      }
    }

    return finalResults;
  }

  Future<List<Map<String, dynamic>>> fetchNearbyFacilities(
    String location,
  ) async {
    var coords = await getLatLngFromAddress(location);
    if (coords == null) return [];

    propertyLatLng = LatLng(coords["lat"]!, coords["lng"]!);

    return await getNearbyPlaces(coords["lat"]!, coords["lng"]!);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double widt = MediaQuery.of(context).size.width;
    double rating = double.parse(widget.property['rating'].toString());

    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    start: width * 0.03,
                    top: height * 0.05,
                    end: width * 0.03,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          widget.property['image'],
                          height: height * 0.55,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),

                      Positioned(
                        top: height * 0.02,
                        left: width * 0.03,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width * 0.12,
                            height: width * 0.12,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_sharp,
                              size: width * 0.05,
                              color: Color(0xFF1F4C6B),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.02,
                        right: width * 0.2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width * 0.12,
                            height: width * 0.12,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.ios_share,
                              size: width * 0.05,
                              color: Color(0xFF1F4C6B),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: height * 0.02,
                        right: width * 0.05,
                        child: Consumer<Createprovider>(
                          builder: (context, cart, child) {
                            bool isAdded = cart.isInCart(widget.property);

                            return InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                if (isAdded) {
                                  cart.removeFromCart(widget.property);
                                } else {
                                  cart.addToCart(widget.property);
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: width * 0.12,
                                height: width * 0.12,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isAdded
                                      ? const Color(0xFF8BC83F)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  isAdded
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isAdded
                                      ? Colors.white
                                      : Colors.pinkAccent,
                                  size: width * 0.06,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: height * 0.02,
                        left: width * 0.04,
                        child: Container(
                          height: height * 0.053,
                          width: width * 0.23,
                          decoration: ShapeDecoration(
                            color: Color.fromARGB(214, 35, 79, 104),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                SizedBox(width: width * 0.01),
                                Text(
                                  widget.property['rating'],
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: height * 0.02,
                        left: width * 0.3,
                        child: Container(
                          height: height * 0.055,
                          width: width * 0.25,
                          decoration: ShapeDecoration(
                            color: Color.fromARGB(214, 35, 79, 104),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.property['property-type'],
                              style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontSize: height * 0.021,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.02,
                    start: width * 0.06,
                    end: width * 0.05,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.property['title'],
                            style: GoogleFonts.lato(
                              color: Color(0xFF1F4C6B),
                              fontSize: height * 0.04,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: height * 0.02,
                                color: Color(0xFF1F4C6B),
                              ),

                              SizedBox(width: width * 0.005),

                              Text(
                                widget.property["location"],
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F4C6B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.property['price']}',
                            style: GoogleFonts.lato(
                              color: Color(0xFF1F4C6B),
                              fontSize: height * 0.04,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          Text(
                            'per month',
                            style: GoogleFonts.lato(
                              color: Color(0xFF1F4C6B),
                              fontSize: height * 0.02,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(top: height * 0.02),
                  child: Container(
                    width: double.infinity,
                    height: height * 0.08,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        SizedBox(width: width * 0.05),
                        SizedBox(
                          width: width * 0.20,
                          height: height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buyOrRent == false
                                  ? const Color(0xFF8BC83F)
                                  : Color(0xFF1F4C6B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                buyOrRent = false;
                              });
                            },

                            child: Text(
                              "Rent",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.05),
                        SizedBox(
                          width: width * 0.20,
                          height: height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buyOrRent == true
                                  ? const Color(0xFF8BC83F)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                buyOrRent = true;
                              });
                            },

                            child: Text(
                              "Buy",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(top: height * 0.02),
                  child: Center(
                    child: Container(
                      width: width * 0.85,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(82, 236, 236, 236),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: width * 0.06),
                          ClipOval(
                            child: Image.asset(
                              widget.property['agent']["image"],
                              width: width * 0.12,
                              height: width * 0.12,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: width * 0.06),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.property["agent"]['name'],
                                style: GoogleFonts.raleway(
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F4C6B),
                                ),
                              ),

                              Text(
                                "Real Estate Agent",
                                style: GoogleFonts.raleway(
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF1F4C6B),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.28),
                          GestureDetector(
                            child: Icon(
                              Icons.message_outlined,
                              size: height * 0.025,
                              color: Color(0xFF1F4C6B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.05),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: width * 0.05),

                      Icon(
                        Icons.bed,
                        color: const Color(0xFF8BC83F),
                        size: height * 0.035,
                      ),

                      SizedBox(width: width * 0.02),

                      Text(
                        '${widget.property['property-rooms']['bedrooms']}  Bedrooms',
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF234F68),
                          fontSize: width * 0.045,
                        ),
                      ),
                      SizedBox(width: width * 0.1),

                      Icon(
                        Icons.bathtub,
                        color: const Color(0xFF8BC83F),
                        size: height * 0.035,
                      ),

                      SizedBox(width: width * 0.02),

                      Text(
                        '${widget.property['property-rooms']['bathroom']}  Bathroom',
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF234F68),
                          fontSize: width * 0.045,
                        ),
                      ),
                      SizedBox(width: width * 0.1),

                      Icon(
                        Icons.kitchen,
                        color: const Color(0xFF8BC83F),
                        size: height * 0.035,
                      ),

                      SizedBox(width: width * 0.02),

                      Text(
                        '${widget.property['property-rooms']['kitchen']}  Kitchen',
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF234F68),
                          fontSize: width * 0.045,
                        ),
                      ),
                      SizedBox(width: width * 0.1),

                      Icon(
                        Icons.store,
                        color: const Color(0xFF8BC83F),
                        size: height * 0.035,
                      ),

                      SizedBox(width: width * 0.02),

                      Text(
                        '${widget.property['property-rooms']['store_room']}  Store Room',
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF234F68),
                          fontSize: width * 0.045,
                        ),
                      ),
                      SizedBox(width: width * 0.1),

                      Icon(
                        Icons.balcony,
                        color: const Color(0xFF8BC83F),
                        size: height * 0.035,
                      ),

                      SizedBox(width: width * 0.02),

                      Text(
                        '${widget.property['property-rooms']['balcony']}  Balcony',
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF234F68),
                          fontSize: width * 0.045,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.04,
                    start: width * 0.05,
                  ),
                  child: Text(
                    'Location & Public Facilities',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.065,

                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.54,
                    ),
                  ),
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: nearbyFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (snapshot.hasError) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Error loading facilities",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("No nearby facilities found"),
                      );
                    }

                    final places = snapshot.data!;

                    // Get nearest of each type
                    Map<String, Map<String, dynamic>> nearest = {};
                    for (var p in places) {
                      String type = p['type'];
                      if (!nearest.containsKey(type) ||
                          p['distance'] < nearest[type]!['distance']) {
                        nearest[type] = p;
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Show only nearest hospital, school, bunk
                        ...nearest.values.map((place) {
                          IconData icon;
                          if (place["type"] == "hospital") {
                            icon = Icons.local_hospital;
                          } else if (place["type"] == "school") {
                            icon = Icons.school;
                          } else {
                            icon = Icons.local_gas_station;
                          }

                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: width * 0.04,
                              top: width * 0.04,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                if (propertyLatLng == null) return;

                                final LatLng destination = LatLng(
                                  place["lat"],
                                  place["lng"],
                                );

                                setState(() {
                                  destinationLatLng = destination;
                                  routePoints = [propertyLatLng!, destination];
                                  showRoute = true;
                                  selectedPlaceType = place["type"];
                                });

                                LatLngBounds bounds = LatLngBounds(
                                  propertyLatLng!,
                                  destination,
                                );

                                mapController.fitBounds(
                                  bounds,
                                  options: FitBoundsOptions(
                                    padding: EdgeInsets.all(50),
                                  ),
                                );
                              },

                              child: Row(
                                children: [
                                  Container(
                                    width: width * 0.12,
                                    height: width * 0.12,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(94, 219, 219, 219),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      icon,
                                      size: height * 0.025,
                                      color: Color(0xFF1F4C6B),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.03),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          place["name"],
                                          style: TextStyle(
                                            fontSize: height * 0.02,
                                            color: Color(0xFF1F4C6B),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        SizedBox(height: height * 0.03),

                        // Show counts of all nearby facilities
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                ' ${places.where((p) => p["type"] == "hospital").length} Hospitals ',
                                style: GoogleFonts.raleway(fontSize: 16),
                              ),
                              Text(
                                '${places.where((p) => p["type"] == "school").length} Schools',
                                style: GoogleFonts.raleway(fontSize: 16),
                              ),
                              Text(
                                '${places.where((p) => p["type"] == "fuel").length} Gas Stations',
                                style: GoogleFonts.raleway(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

                if (propertyLatLng != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 30,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: FlutterMap(
                          mapController: mapController,
                          options: MapOptions(
                            initialCenter: propertyLatLng!,
                            initialZoom: 15,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              userAgentPackageName: 'com.example.realestate',
                            ),
                            if (showRoute)
                              PolylineLayer(
                                polylines: [
                                  Polyline(
                                    points: routePoints,
                                    strokeWidth: 4,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            // 📍 Markers
                            MarkerLayer(
                              markers: [
                                if (propertyLatLng != null)
                                  Marker(
                                    point: propertyLatLng!,
                                    width: 80,
                                    height: 80,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Marker background shape
                                        Image.asset(
                                          'assets/Vector.png', // your marker pin image
                                          width: 80,
                                          height: 80,
                                        ),

                                        // Center property image
                                        Positioned(
                                          top: 22,
                                          child: ClipOval(
                                            child: Image.asset(
                                              widget.property['image'],
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (destinationLatLng != null)
                                  Marker(
                                    point: destinationLatLng!,
                                    width: 80,
                                    height: 80,
                                    alignment: Alignment.center,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Marker Image
                                        Image.asset(
                                          'assets/Vector.png',
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.contain,
                                        ),

                                        Positioned(
                                          top: 25,
                                          child: Container(
                                            width: 23,
                                            height: 23,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Icon(
                                                selectedPlaceType == "hospital"
                                                    ? Icons.local_hospital
                                                    : selectedPlaceType ==
                                                          "school"
                                                    ? Icons.school
                                                    : Icons.local_gas_station,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.02,
                    start: width * 0.05,
                  ),
                  child: Text(
                    'Cost of Living',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.065,

                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.54,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.03,
                    start: width * 0.09,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '₹ ${widget.property['cost_of_living']} ',
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF242B5C),
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.005),
                        child: Text(
                          "/month",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF242B5C),
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(start: width * 0.09),
                  child: Text(
                    "From average citizen spend around this location",
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.03,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.07,
                    start: width * 0.05,
                  ),
                  child: Text(
                    'Reviews',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.065,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.54,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.04,
                    start: width * 0.09,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.15,
                        height: width * 0.15,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(193, 195, 202, 204),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset('assets/star.png'),
                      ),

                      SizedBox(width: width * 0.04),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  if (index < rating.floor()) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: width * 0.035,
                                    );
                                  } else if (index < rating &&
                                      rating % 1 >= 0.5) {
                                    return Icon(
                                      Icons.star_half,
                                      color: Colors.amber,
                                      size: width * 0.035,
                                    );
                                  } else {
                                    return Icon(
                                      Icons.star_border,
                                      color: Colors.amber,
                                      size: width * 0.035,
                                    );
                                  }
                                }),
                              ),
                              SizedBox(width: width * 0.02),
                              Text(
                                widget.property['rating'],
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFF242B5C),
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.54,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "From ${widget.property['agent']['reviews']} reviews",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: width * 0.2),
                      Stack(
                        children: [
                          SizedBox(
                            width: width * 0.18,
                            height: width * 0.08,
                            child: Stack(
                              children: [
                                // First Image
                                Positioned(
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/person1.png',
                                        width: width * 0.08,
                                        height: width * 0.08,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                // Second Image
                                Positioned(
                                  left: width * 0.05,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/person2.png',
                                        width: width * 0.08,
                                        height: width * 0.08,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                // Third Image
                                Positioned(
                                  left: width * 0.10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/person3.png',
                                        width: width * 0.08,
                                        height: width * 0.08,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: width * 0.05),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.05,
                    start: width * 0.09,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/person4.png',
                          width: width * 0.15,
                          height: width * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Kurt Mullins",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.54,
                                ),
                              ),
                              SizedBox(width: width * 0.21),
                              Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    if (i < rating.floor())
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      )
                                    else if (i < rating && rating % 1 >= 0.5)
                                      Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                        size: 18,
                                      )
                                    else
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur \nadipiscing elit, sed do eiusmod tempor \nincididunt ut labore et dolore magna aliqua.",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.54,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "8 Days ago",
                            style: GoogleFonts.raleway(
                              color: Colors.grey,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.05,
                    start: width * 0.09,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/reviews_img1.png',
                          width: width * 0.15,
                          height: width * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Kay Swanson",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.54,
                                ),
                              ),
                              SizedBox(width: width * 0.21),
                              Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    if (i < rating.floor())
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      )
                                    else if (i < rating && rating % 1 >= 0.5)
                                      Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                        size: 18,
                                      )
                                    else
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "Sed ut perspiciatis unde omnis iste natus \nerror sit voluptatem accusantium doloremque \nlaudantium, totam rem aperia.",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.54,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "12 Days ago",
                            style: GoogleFonts.raleway(
                              color: Colors.grey,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


  Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.05,
                    start: width * 0.09,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/person4.png',
                          width: width * 0.15,
                          height: width * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Kurt Mullins",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.54,
                                ),
                              ),
                              SizedBox(width: width * 0.21),
                              Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    if (i < rating.floor())
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      )
                                    else if (i < rating && rating % 1 >= 0.5)
                                      Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                        size: 18,
                                      )
                                    else
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur \nadipiscing elit, sed do eiusmod tempor \nincididunt ut labore et dolore magna aliqua.",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.54,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "8 Days ago",
                            style: GoogleFonts.raleway(
                              color: Colors.grey,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
 

    Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: height * 0.05,
                    start: width * 0.09,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/reviews_img1.png',
                          width: width * 0.15,
                          height: width * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Kay Swanson",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.54,
                                ),
                              ),
                              SizedBox(width: width * 0.21),
                              Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    if (i < rating.floor())
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      )
                                    else if (i < rating && rating % 1 >= 0.5)
                                      Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                        size: 18,
                                      )
                                    else
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "Sed ut perspiciatis unde omnis iste natus \nerror sit voluptatem accusantium doloremque \nlaudantium, totam rem aperia.",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.54,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "17 Days ago",
                            style: GoogleFonts.raleway(
                              color: Colors.grey,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                SizedBox(height: height * 0.2),
              ],
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: -30,
            child: Container(
              height: height * 0.16,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white.withOpacity(0.4), // mid fade
                    Colors.white.withOpacity(0), // fully transparent
                  ],
                  stops: const [0.0, 0.3, 0.6, 1.0],
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8BC83F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: width * 0.59,
                    height: height * 0.07,
                    child: Center(
                      child: Text(
                        "Start Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
