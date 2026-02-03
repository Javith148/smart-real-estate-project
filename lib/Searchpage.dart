import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:real_esate_finder/widgets/locationContainer.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  // variable declartaion

  LatLng selectedLocation = const LatLng(11.0168, 76.9558);
  List<Map<String, dynamic>> currentFilteredList = [];
  Set<Marker> markers = {};
  bool selectedHouse = false;
  bool selectedApartment = false;
  bool selectedVilla = false;
  String selectedPriceSort = "";
  LatLng currentCameraPosition = const LatLng(11.0168, 76.9558);
  bool hasNearbyProperty = true;
  int nearbyPropertyCount = 0;
  List<Map<String, dynamic>> nearbyProperties = [];

  GoogleMapController? mapController;
  TextEditingController searchController = TextEditingController();

  String? _lastAddress;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final address = context.watch<Createprovider>().address;

    if (address.isEmpty) return;

    if (_lastAddress != address) {
      _lastAddress = address;
      moveCameraToAddress();
    }
  }

  @override
  void initState() {
    super.initState();
    createFilteredMarkers();
  }


  List<Map<String, dynamic>> propertyList = [
    {
      "image": "assets/nearby1.png",
      "title": "Wings Tower",
      "price": "₹30k",
      "rating": "4.9",
      "property-type": "Apartment",
      "location": "Coimbatore, TN",
    },
    {
      "image": "assets/nearby2.png",
      "title": "Mill Sper House",
      "price": "₹20k",
      "rating": "4.8",
      "property-type": "House",
      "location": "Peelamedu, TN",
    },
    {
      "image": "assets/nearby3.png",
      "title": "Garden Residency",
      "price": "₹25k",
      "rating": "4.7",
      "property-type": "Apartment",
      "location": "RS Puram, TN",
    },
    {
      "image": "assets/nearby4.png",
      "title": "Elite Apartment",
      "price": "₹28k",
      "rating": "4.9",
      "property-type": "Apartment",
      "location": "Saibaba Colony, TN",
    },
    {
      "image": "assets/nearby4.png",
      "title": "Elite Apartment",
      "price": "₹28k",
      "rating": "4.9",
      "property-type": "Apartment",
      "location": "Selvapuram, TN",
    },
  ];

  /// ADDRESS → LAT LNG → CAMERA MOVE
  Future<void> moveCameraToAddress() async {
    final address = context.read<Createprovider>().address;

    List<Location> locations = await locationFromAddress(address);

    final latLng = LatLng(locations.first.latitude, locations.first.longitude);

    currentCameraPosition = latLng; // 🔥 ADD THIS

    mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));

    // 🔥 ADD THIS ALSO (initial check)
    final nearby = isAnyMarkerNearby(currentCameraPosition, getMarkerLatLngs());

    setState(() {
      hasNearbyProperty = nearby;
    });
  }

  List<Map<String, dynamic>> getNearbyPropertyDetails(LatLng cameraPosition) {
    List<Map<String, dynamic>> result = [];

    for (final marker in markers) {
      double distance = calculateDistance(
        cameraPosition.latitude,
        cameraPosition.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );

      if (distance <= 2) {
        final matchedItem = currentFilteredList.firstWhere(
          (item) => item["title"] == marker.infoWindow.title,
          orElse: () => {},
        );

        if (matchedItem.isNotEmpty) {
          result.add({
            "title": matchedItem["title"],
            "price": matchedItem["price"],
            "rating": matchedItem["rating"],
            "image": matchedItem["image"],
            "location": matchedItem["location"],
            "property-type": matchedItem["property-type"],
            "distance": distance.toStringAsFixed(1),
          });
        }
      }
    }

    return result;
  }

  Future<BitmapDescriptor> markerWithCenterImage({
    required String markerAsset, // your pin image
    required String profileAsset, // list/profile image
  }) async {
    /// Load marker base image
    final ByteData markerData = await rootBundle.load(markerAsset);
    final ui.Codec markerCodec = await ui.instantiateImageCodec(
      markerData.buffer.asUint8List(),
      targetWidth: 95,
    );
    final ui.FrameInfo markerFrame = await markerCodec.getNextFrame();
    final ui.Image markerImage = markerFrame.image;

    /// Load profile image
    final ByteData profileData = await rootBundle.load(profileAsset);
    final ui.Codec profileCodec = await ui.instantiateImageCodec(
      profileData.buffer.asUint8List(),
      targetWidth: 60,
    );
    final ui.FrameInfo profileFrame = await profileCodec.getNextFrame();
    final ui.Image profileImage = profileFrame.image;

    final double width = markerImage.width.toDouble();
    final double height = markerImage.height.toDouble();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    /// 1️⃣ Draw your marker image
    canvas.drawImage(markerImage, Offset.zero, Paint());

    /// 2️⃣ Profile image center position (adjust Y if needed)
    final Offset imageCenter = Offset(width / 2, height * 0.38);

    /// White background circle
    canvas.drawCircle(imageCenter, 36, Paint()..color = Colors.white);

    /// Profile image inside circle
    final Paint imagePaint = Paint()
      ..shader = ImageShader(
        profileImage,
        TileMode.clamp,
        TileMode.clamp,
        Matrix4.identity().storage,
      );

    canvas.drawCircle(imageCenter, 32, imagePaint);

    final ui.Image finalImage = await recorder.endRecording().toImage(
      width.toInt(),
      height.toInt(),
    );

    final ByteData? pngBytes = await finalImage.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return BitmapDescriptor.fromBytes(pngBytes!.buffer.asUint8List());
  }

  Future<LatLng?> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      debugPrint("Geocoding failed for $address : $e");
    }
    return null;
  }

  Future<void> createFilteredMarkers() async {
    Set<Marker> tempMarkers = {};
    final filteredList = getFilteredProperties();

    currentFilteredList = filteredList;
    for (int i = 0; i < filteredList.length; i++) {
      final LatLng? latLng = await getLatLngFromAddress(
        filteredList[i]["location"],
      );

      if (latLng != null) {
        final icon = await markerWithCenterImage(
          markerAsset: "assets/Vector.png",
          profileAsset: filteredList[i]["image"],
        );

        tempMarkers.add(
          Marker(
            markerId: MarkerId("property_$i"),
            position: latLng,
            icon: icon,
            infoWindow: InfoWindow(
              title: filteredList[i]["title"], // 🔥 LINK
            ),
          ),
        );
      }
    }

    if (!mounted) return;
    setState(() {
      markers = tempMarkers;
    });
  }

  int parsePrice(String price) {
    final cleaned = price
        .replaceAll("₹", "")
        .replaceAll("k", "")
        .replaceAll("K", "")
        .trim();

    return int.tryParse(cleaned)! * 1000;
  }

  List<Map<String, dynamic>> getFilteredProperties() {
    List<Map<String, dynamic>> filtered = [...propertyList];

    // 🔹 PROPERTY TYPE FILTER
    filtered = filtered.where((item) {
      if (selectedHouse && item["property-type"] == "House") return true;
      if (selectedApartment && item["property-type"] == "Apartment")
        return true;
      if (selectedVilla && item["property-type"] == "Villa") return true;

      if (!selectedHouse && !selectedApartment && !selectedVilla) return true;
      return false;
    }).toList();

    // 🔹 PRICE SORT
    if (selectedPriceSort == "low") {
      filtered.sort(
        (a, b) => parsePrice(a["price"]).compareTo(parsePrice(b["price"])),
      );
    } else if (selectedPriceSort == "high") {
      filtered.sort(
        (a, b) => parsePrice(b["price"]).compareTo(parsePrice(a["price"])),
      );
    }

    return filtered;
  }

  Future<void> openFilters() async {
    final result = await openFilterSheet(context);

    if (result != null) {
      setState(() {
        selectedHouse = result["house"];
        selectedApartment = result["apartment"];
        selectedVilla = result["villa"];
        selectedPriceSort = result["priceSort"];
      });
      await createFilteredMarkers();
    }
  }

  Future<Map<String, dynamic>?> openFilterSheet(BuildContext context) async {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    bool house = selectedHouse;
    bool apartment = selectedApartment;
    bool villa = selectedVilla;
    String priceSort = selectedPriceSort;

    TextStyle filterItemText() {
      return TextStyle(
        fontSize: width * 0.038,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF1F4C6B),
      );
    }

    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: width * 0.07,
                right: width * 0.06,
                top: height * 0.03,
                bottom: height * 0.03,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Drag Indicator
                  Center(
                    child: Container(
                      width: width * 0.12,
                      height: height * 0.005,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // 🔹 Title + Clear
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F4C6B),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            house = false;
                            apartment = false;
                            villa = false;
                            priceSort = "";
                          });
                        },
                        child: Text(
                          "Clear",
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF8BC83F),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // 🔹 Property Type
                  Center(
                    child: Text(
                      "Property Type",
                      style: TextStyle(
                        fontSize: width * 0.043,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F4C6B),
                      ),
                    ),
                  ),

                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: const Color(0xFF8BC83F),
                    title: Text("House", style: filterItemText()),
                    value: house,
                    onChanged: (v) => setState(() => house = v!),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: const Color(0xFF8BC83F),
                    title: Text("Apartment", style: filterItemText()),
                    value: apartment,
                    onChanged: (v) => setState(() => apartment = v!),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: const Color(0xFF8BC83F),
                    title: Text("Villa", style: filterItemText()),
                    value: villa,
                    onChanged: (v) => setState(() => villa = v!),
                  ),

                  SizedBox(height: height * 0.02),

                  // 🔹 Sort by Price
                  Center(
                    child: Text(
                      "Sort by Price",
                      style: TextStyle(
                        fontSize: width * 0.043,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F4C6B),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  Row(
                    children: [
                      // LOW → HIGH
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => priceSort = "low"),
                          child: Container(
                            height: height * 0.065,
                            decoration: BoxDecoration(
                              color: priceSort == "low"
                                  ? const Color(0xFF1F4C6B)
                                  : const Color(0xFFF5F7F9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.trending_up_rounded,
                                  color: priceSort == "low"
                                      ? Colors.white
                                      : const Color(0xFF1F4C6B),
                                ),
                                SizedBox(width: width * 0.02),
                                Text(
                                  "Low to High",
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w600,
                                    color: priceSort == "low"
                                        ? Colors.white
                                        : const Color(0xFF1F4C6B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: width * 0.04),

                      // HIGH → LOW
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => priceSort = "high"),
                          child: Container(
                            height: height * 0.065,
                            decoration: BoxDecoration(
                              color: priceSort == "high"
                                  ? const Color(0xFF1F4C6B)
                                  : const Color(0xFFF5F7F9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.trending_down_rounded,
                                  color: priceSort == "high"
                                      ? Colors.white
                                      : const Color(0xFF1F4C6B),
                                ),
                                SizedBox(width: width * 0.02),
                                Text(
                                  "High to Low",
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w600,
                                    color: priceSort == "high"
                                        ? Colors.white
                                        : const Color(0xFF1F4C6B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.04),

                  // 🔹 APPLY
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8BC83F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context, {
                          "house": house,
                          "apartment": apartment,
                          "villa": villa,
                          "priceSort": priceSort,
                        });
                      },
                      child: SizedBox(
                        width: width * 0.7,
                        height: height * 0.065,
                        child: Center(
                          child: Text(
                            "Apply Filters",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.042,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;

    double dLat = _degToRad(lat2 - lat1);
    double dLon = _degToRad(lon2 - lon1);

    double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degToRad(double deg) {
    return deg * (pi / 180);
  }

  bool isAnyMarkerNearby(LatLng cameraPosition, List<LatLng> markers) {
    for (var marker in markers) {
      double distance = calculateDistance(
        cameraPosition.latitude,
        cameraPosition.longitude,
        marker.latitude,
        marker.longitude,
      );

      if (distance <= 2) {
        return true;
      }
    }
    return false;
  }

  List<LatLng> getMarkerLatLngs() {
    return markers.map((marker) => marker.position).toList();
  }

  int countNearbyMarkers(LatLng cameraPosition, List<LatLng> markers) {
    int count = 0;

    for (var marker in markers) {
      double distance = calculateDistance(
        cameraPosition.latitude,
        cameraPosition.longitude,
        marker.latitude,
        marker.longitude,
      );

      if (distance <= 2) {
        count++;
      }
    }
    return count;
  }

  Future<void> applySearch(String query) async {
   if (query.isEmpty) {
  // 🔥 RESET TO NORMAL MODE
  currentFilteredList = getFilteredProperties();

  await createFilteredMarkers();

  final nearbyList = getNearbyPropertyDetails(currentCameraPosition);

  setState(() {
    nearbyProperties = nearbyList;
    hasNearbyProperty = nearbyList.isNotEmpty;
    nearbyPropertyCount = nearbyList.length;
  });

  return;
}

    

    final searchedList = propertyList.where((item) {
      final title = item["title"].toString().toLowerCase();
      final location = item["location"].toString().toLowerCase();
      final type = item["property-type"].toString().toLowerCase();

      return title.contains(query.toLowerCase()) ||
          location.contains(query.toLowerCase()) ||
          type.contains(query.toLowerCase());
    }).toList();

    currentFilteredList = searchedList;

    Set<Marker> tempMarkers = {};

    for (int i = 0; i < searchedList.length; i++) {
      final latLng = await getLatLngFromAddress(searchedList[i]["location"]);
      if (latLng == null) continue;

      final icon = await markerWithCenterImage(
        markerAsset: "assets/Vector.png",
        profileAsset: searchedList[i]["image"],
      );

      tempMarkers.add(
        Marker(
          markerId: MarkerId("search_$i"),
          position: latLng,
          icon: icon,
          infoWindow: InfoWindow(
            title: searchedList[i]["title"], // 🔥 MUST
          ),
        ),
      );

      // 🔥 MOVE CAMERA TO FIRST SEARCH RESULT
      if (i == 0) {
        mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
        currentCameraPosition = latLng;

        // 🔥 FORCE UPDATE NEARBY DATA
        nearbyProperties = getNearbyPropertyDetails(latLng);

        // final nearby = isAnyMarkerNearby(
        //   currentCameraPosition,
        //   tempMarkers.map((m) => m.position).toList(),
        // );

        // final count = countNearbyMarkers(
        //   currentCameraPosition,
        //   tempMarkers.map((m) => m.position).toList(),
        // );

        final List<Map<String, dynamic>> nearbyList = getNearbyPropertyDetails(
          currentCameraPosition,
        );

        setState(() {
          markers = tempMarkers;

          nearbyProperties = nearbyList; // 🔥 VERY IMPORTANT
          hasNearbyProperty = nearbyList.isNotEmpty; // 🔥 FIX
          nearbyPropertyCount = nearbyList.length; // 🔥 FIX
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: GoogleMap(
              markers: markers,
              onMapCreated: (controller) {
                mapController = controller;
              },
              onCameraMove: (position) {
                currentCameraPosition = position.target;
              },
              onCameraIdle: () {
                final nearby = isAnyMarkerNearby(
                  currentCameraPosition,
                  getMarkerLatLngs(),
                );
                nearbyPropertyCount = countNearbyMarkers(
                  currentCameraPosition,
                  getMarkerLatLngs(),
                );
                nearbyProperties = getNearbyPropertyDetails(
                  currentCameraPosition,
                );

                setState(() {
                  hasNearbyProperty = nearby;
                });
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(11.0168, 76.9558),
                zoom: 15,
              ),
            ),
          ),

          Positioned(
            top: height * 0.05,
            left: width * 0.05,
            child: Locationcontainer(),
          ),
          Positioned(
            top: height * 0.05,
            right: width * 0.05,
            child: GestureDetector(
              onTap: () {
                openFilters();
              },
              child: Container(
                width: width * 0.12,
                height: width * 0.12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.tune_rounded,
                  size: width * 0.05,
                  color: Color(0xFF1F4C6B),
                ),
              ),
            ),
          ),

          Positioned(
            top: height * 0.12,
            left: width * 0.05,

            child: SizedBox(
              height: height * 0.08,
              width: width * 0.89,
              child: TextFormField(
                controller: searchController,
                autofocus: false,
                onFieldSubmitted: (value) {
                  applySearch(value);

                  // 🔥 CLEAR SEARCH TEXT
                  searchController.clear();

                  // 🔥 KEYBOARD CLOSE
                  FocusScope.of(context).unfocus();
                },

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,

                  contentPadding: EdgeInsets.symmetric(
                    vertical: height * 0.025,
                    horizontal: width * 0.04,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: const Color(0xFF242B5C),
                      width: 1.5,
                    ),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),

                  labelText: "Search Home, Apartment, etc",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: width * 0.03),
                    child: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
          hasNearbyProperty
              ? Positioned(
                  bottom: height * 0.20,
                  left: width * 0.05,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF234F68),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SizedBox(
                      width: width * 0.35,
                      height: height * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: width * 0.02),
                          Container(
                            width: width * 0.08,
                            height: width * 0.08,
                            decoration: const BoxDecoration(
                              color: Colors.lightGreen,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: hasNearbyProperty
                                  ? Text(
                                      nearbyPropertyCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const Text(
                                      "!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Text(
                            "Nearby You",
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Positioned(
                  bottom: height * 0.09,
                  left: width * 0.05,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF234F68),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SizedBox(
                      width: width * 0.35,
                      height: height * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: width * 0.02),
                          Container(
                            width: width * 0.08,
                            height: width * 0.08,
                            decoration: const BoxDecoration(
                              color: Colors.lightGreen,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: hasNearbyProperty
                                  ? Text(
                                      nearbyPropertyCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const Text(
                                      "!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Text(
                            "Nearby You",
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

          Positioned(
            bottom: height * 0.02,
            left: width * 0.05,
            child: hasNearbyProperty
                ? Container()
                : Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.22,
                      vertical: height * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF234F68),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Can't found real estate nearby you",
                      style: TextStyle(
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
          if (nearbyProperties.isNotEmpty)
            Positioned(
              bottom: height * 0.01,
              left: width * 0.0,
              right: width * 0.0,
              child: SizedBox(
                height: height * 0.175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nearbyProperties.length,
                  itemBuilder: (context, index) {
                    final item = nearbyProperties[index];
                    final width = MediaQuery.of(context).size.width;
                    final height = MediaQuery.of(context).size.height;

                    return Container(
                      width: width * 0.8,

                      margin: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(blurRadius: 8, color: Colors.black12),
                        ],
                      ),
                      padding: EdgeInsetsDirectional.all(width * 0.03),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  item["image"],
                                  fit: BoxFit.contain,
                                ),
                              ),

                              Positioned(
                                left: width * 0.02,
                                top: height * 0.01,
                                child: Consumer<Createprovider>(
                                  builder: (context, cart, child) {
                                    bool isAdded = cart.isInCart(item);

                                    return InkWell(
                                      onTap: () {
                                        if (isAdded) {
                                          cart.removeFromCart(item);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "${item['title']} removed from favorites",
                                              ),
                                              duration: Duration(seconds: 1),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        } else {
                                          cart.addToCart(item);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "${item['title']} added to favorites",
                                              ),
                                              duration: Duration(seconds: 1),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        }
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 250),
                                        width: width * 0.06,
                                        height: width * 0.06,
                                        decoration: BoxDecoration(
                                          color: isAdded
                                              ? Colors.green
                                              : Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
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
                                          size: height * 0.015,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                left: width * 0.02,
                                top: height * 0.11,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.035,
                                    vertical: height * 0.009,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF234F68),
                                        Color(0xFF1B3A4B),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    item["property-type"]
                                        .toString()
                                        .toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: width * 0.02,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.directional(
                              start: width * 0.055,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  item["title"],
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFF234F68),
                                    fontSize: width * 0.05,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: height * 0.01),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: height * 0.015,
                                    ),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      item["rating"],
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey,
                                        fontSize: width * 0.03,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: height * 0.020,
                                      color: const Color(0xFF1F4C6B),
                                    ),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      item["location"],
                                      style: GoogleFonts.raleway(
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1F4C6B),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.01),
                                Padding(
                                  padding: EdgeInsetsGeometry.directional(
                                    start: width * 0.01,
                                  ),
                                  child: Text(
                                    "${item["distance"]} km away",
                                    style: GoogleFonts.raleway(
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1F4C6B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
