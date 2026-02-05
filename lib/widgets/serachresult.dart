import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class Searchresult extends StatefulWidget {
  final TextEditingController controller;
  const Searchresult({super.key, required this.controller});

  @override
  State<Searchresult> createState() => _SearchresultState();
}

class _SearchresultState extends State<Searchresult> {
  final TextEditingController locationController = TextEditingController();
  GoogleMapController? mapController;
  BitmapDescriptor? customMarker;
  List<String> appliedFilters = [];
  String? selectedLocation;

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

  bool isGridView = true;
  late FocusNode _focusNode;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    result = propertyList;

    markerWithCenterImage(
      markerAsset: 'assets/Vector.png',
      profileAsset: 'assets/user.png',
    ).then((icon) {
      setState(() {
        customMarker = icon;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  bool resultnotfound = true;

  List<Map<String, dynamic>> result = [];
  void fliter_property(String value) {
    setState(() {
      if (value.isEmpty) {
        result = propertyList;
        resultnotfound = false;
      } else {
        result = propertyList.where((item) {
          return item['title'].toString().toLowerCase().contains(
                value.toLowerCase(),
              ) ||
              item['location'].toString().toLowerCase().contains(
                value.toLowerCase(),
              ) ||
              item['property-type'].toString().toLowerCase().contains(
                value.toLowerCase(),
              );
        }).toList();

        resultnotfound = result.isEmpty;
      }
    });
  }

  void applyFiltersToResult() {
    List<Map<String, dynamic>> filtered = propertyList;

    // 🔹 Property Type filter
    if (selectedItems.isNotEmpty && !selectedItems.contains(0)) {
      final selectedTypes = selectedItems.map((i) => propertyTypes[i]).toList();

      filtered = filtered.where((item) {
        return selectedTypes.contains(item['property-type']);
      }).toList();
    }

    // 🔹 Location filter
    if (locationController.text.isNotEmpty) {
      final location = locationController.text.toLowerCase();

      filtered = filtered.where((item) {
        return item['location'].toString().toLowerCase().contains(location);
      }).toList();
    }

    // 🔹 Update result list
    setState(() {
      result = filtered;
      resultnotfound = result.isEmpty;
    });
  }

  Future<BitmapDescriptor> markerWithCenterImage({
    required String markerAsset,
    required String profileAsset,
  }) async {
    // 🔹 Load marker image
    final ByteData markerData = await rootBundle.load(markerAsset);
    final ui.Codec markerCodec = await ui.instantiateImageCodec(
      markerData.buffer.asUint8List(),
      targetWidth: 65,
    );
    final ui.FrameInfo markerFrame = await markerCodec.getNextFrame();
    final ui.Image markerImage = markerFrame.image;

    // 🔹 Load profile image
    final ByteData profileData = await rootBundle.load(profileAsset);
    final ui.Codec profileCodec = await ui.instantiateImageCodec(
      profileData.buffer.asUint8List(),
      targetWidth: 40,
    );
    final ui.FrameInfo profileFrame = await profileCodec.getNextFrame();
    final ui.Image profileImage = profileFrame.image;

    final double width = markerImage.width.toDouble();
    final double height = markerImage.height.toDouble();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // 🔹 Draw marker base
    canvas.drawImage(markerImage, Offset.zero, Paint());

    // 🔹 PERFECT CENTER POSITION
    final Offset imageCenter = Offset(width / 2, height / 2.5);

    // 🔹 White outer circle
    canvas.drawCircle(imageCenter, 22, Paint()..color = Colors.white);

    // 🔹 Profile image shader (CENTER FIX)
    const double imageSize = 40;

    final Paint imagePaint = Paint()
      ..shader = ImageShader(
        profileImage,
        TileMode.clamp,
        TileMode.clamp,
        (Matrix4.identity()
              ..translate(
                imageCenter.dx - imageSize / 2,
                imageCenter.dy - imageSize / 2,
              )
              ..scale(
                imageSize / profileImage.width,
                imageSize / profileImage.height,
              ))
            .storage,
      );

    // 🔹 Draw profile image circle
    canvas.drawCircle(imageCenter, 20, imagePaint);

    // 🔹 Convert to PNG
    final ui.Image finalImage = await recorder.endRecording().toImage(
      width.toInt(),
      height.toInt(),
    );

    final ByteData? pngBytes = await finalImage.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return BitmapDescriptor.fromBytes(pngBytes!.buffer.asUint8List());
  }

  void searchAndMoveLocation(
    String location,
    void Function(void Function()) setModalState,
  ) async {
    if (location.trim().isEmpty) return;

    try {
      final locations = await locationFromAddress(location);

      if (locations.isNotEmpty && customMarker != null) {
        final position = LatLng(
          locations.first.latitude,
          locations.first.longitude,
        );

        setModalState(() {
          markers.clear();
          markers.add(
            Marker(
              markerId: const MarkerId("single_location"),
              position: position,
              icon: customMarker!,
              infoWindow: InfoWindow(title: location),
            ),
          );
        });

        mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
      }
    } catch (e) {
      debugPrint("Location not found");
    }
  }

  final Set<int> selectedItems = {};
  final List<String> propertyTypes = ["All", "House", "Villa", "Apartment"];

  void filter_drawer(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: width * 0.07,
                right: width * 0.06,
                top: height * 0.03,
                bottom:
                    MediaQuery.of(context).viewInsets.bottom + height * 0.03,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 Drag handle
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

                    SizedBox(height: height * 0.04),

                    /// 🔹 Title + Reset
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
                        SizedBox(
                          width: width * 0.20,
                          height: height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1F4C6B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {
                              setModalState(() {
                                selectedItems.clear();

                                locationController.clear();

                                markers.clear();
                              });

                              setState(() {
                                result = propertyList;
                                resultnotfound = false;
                              });
                            },

                            child: Text(
                              "Reset",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.03),

                    /// 🔹 Property Type title
                    Row(
                      children: [
                        Text(
                          "Property Type",
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1F4C6B),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -width * 0.02),
                          child: Container(
                            width: width * 0.012,
                            height: width * 0.012,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.03),

                    /// 🔹 MULTI SELECT BUTTONS
                    Wrap(
                      spacing: width * 0.03,
                      runSpacing: height * 0.015,
                      children: List.generate(propertyTypes.length, (index) {
                        final isSelected = selectedItems.contains(index);

                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              if (index == 0) {
                                selectedItems.clear();
                                selectedItems.add(0);
                              } else {
                                selectedItems.remove(0);
                                isSelected
                                    ? selectedItems.remove(index)
                                    : selectedItems.add(index);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF1F4C6B)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFF1F4C6B),
                              ),
                            ),
                            child: Text(
                              propertyTypes[index],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF1F4C6B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: height * 0.04),
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1F4C6B),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    TextField(
                      controller: locationController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        searchAndMoveLocation(value, setModalState);
                      },

                      decoration: InputDecoration(
                        hintText: "Search location",

                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 8),
                          child: const Icon(
                            Icons.location_on,
                            color: Color(0xFF1F4C6B),
                          ),
                        ),

                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 25, left: 8),
                          child: GestureDetector(
                            onTap: () {
                              searchAndMoveLocation(
                                locationController.text,
                                setModalState,
                              );
                            },

                            child: const Icon(
                              Icons.search,
                              color: Color(0xFF1F4C6B),
                            ),
                          ),
                        ),

                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),

                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 22,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GoogleMap(
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(11.0168, 76.9558),
                            zoom: 12,
                          ),
                          markers: markers,
                          zoomControlsEnabled: false,
                        ),
                      ),
                    ),

                    /// 🔹 Apply button
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.065,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F4C6B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // 🔹 Update applied filter chips
                          setState(() {
                            appliedFilters.clear();

                            for (int i in selectedItems) {
                              if (propertyTypes[i] != "All") {
                                appliedFilters.add(propertyTypes[i]);
                              }
                            }

                            if (locationController.text.isNotEmpty) {
                              selectedLocation = locationController.text;
                              appliedFilters.add(selectedLocation!);
                            }
                          });

                          // 🔹 APPLY FILTER TO RESULT LIST (🔥 MAIN LINE)
                          applyFiltersToResult();

                          Navigator.pop(context);
                        },

                        child: const Text(
                          "Apply Filter",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget filterChip(String text, VoidCallback onRemove) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: height * 0.06,
      decoration: BoxDecoration(
        color: const Color.fromARGB(135, 194, 193, 193),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: width * 0.09,
              height: width * 0.09,
              decoration: const BoxDecoration(
                color: Color(0xFF8BC83F),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: width * 0.045,
              ),
            ),
          ),
          const SizedBox(width: 7),
          Text(
            text,
            style: GoogleFonts.raleway(
              color: const Color(0xFF242B5C),
              fontSize: width * 0.038,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 7),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: width * 0.04),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Text(
          "Search results",
          style: GoogleFonts.lato(fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: width * 0.04),
            child: IconButton(
              onPressed: () => filter_drawer(context),
              icon: const Icon(Icons.tune_rounded),
            ),
          ),
        ],
      ),

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        onVerticalDragDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.02),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  onChanged: fliter_property,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,

                    contentPadding: EdgeInsets.symmetric(
                      vertical: height * 0.022,
                      horizontal: width * 0.03,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF234F68),
                        width: 2,
                      ),
                    ),

                    // ✅ ICON SWITCH WORKS NOW
                    prefixIcon: _focusNode.hasFocus
                        ? null
                        : const Icon(Icons.search),

                    suffixIcon: _focusNode.hasFocus
                        ? const Icon(Icons.search, color: Color(0xFF234F68))
                        : const Icon(
                            Icons.mic_none_outlined,
                            color: Colors.grey,
                          ),

                    labelText: "Search Home, Apartment, etc",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.directional(start: width * 0.05),
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${result.length} Estate',
                            style: TextStyle(
                              color: const Color(0xFF204D6C),
                              fontSize: width * 0.060,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: width * 0.52),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.grid_view_rounded,
                            color: isGridView
                                ? const Color(0xFF204D6C)
                                : Colors.grey,
                          ),
                          onPressed: () => setState(() => isGridView = true),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.list,
                            color: !isGridView
                                ? const Color(0xFF204D6C)
                                : Colors.grey,
                          ),
                          onPressed: () => setState(() => isGridView = false),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 Applied Filters Chips
                    if (appliedFilters.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.015),
                        child: SizedBox(
                          height: height * 0.065,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: appliedFilters.length,
                            itemBuilder: (context, index) {
                              return filterChip(appliedFilters[index], () {
                                setState(() {
                                  appliedFilters.removeAt(index);

                                  // 🔹 if location chip removed
                                  if (appliedFilters.isEmpty) {
                                    locationController.clear();
                                  }
                                });
                              });
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: resultnotfound
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height * 0.14),
                            Image.asset("assets/resultnotfound.png"),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Search ',
                                    style: GoogleFonts.lato(
                                      color: const Color(0xFF234F68),
                                      fontSize: width * 0.08,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'not found',
                                    style: TextStyle(
                                      color: const Color(0xFF234F68),
                                      fontSize: width * 0.08,
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              "Sorry, we can’t find the real estates you are looking for. \nMaybe, a little spelling mistake?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(fontSize: width * 0.04),
                            ),
                          ],
                        ),
                      )
                    : isGridView
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: (width * 0.45) / (height * 0.32),
                        ),

                        itemCount: result.length,

                        itemBuilder: (context, index) {
                          final item = result[index];

                          return Card(
                            child: Container(
                              width: width * 0.45,
                              height: height * 0.3,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(186, 244, 242, 242),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          item["image"],
                                          height: height * 0.23,
                                          width: width * 0.4,
                                          fit: BoxFit.contain,
                                        ),

                                        Positioned(
                                          right: width * 0.03,
                                          top: height * 0.025,
                                          child: Consumer<Createprovider>(
                                            builder: (context, cart, child) {
                                              bool isAdded = cart.isInCart(
                                                item,
                                              );

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

                                                        backgroundColor:
                                                            Colors.redAccent,
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
                                                      ),
                                                    );
                                                  }
                                                },

                                                child: AnimatedContainer(
                                                  duration: Duration(
                                                    milliseconds: 250,
                                                  ),
                                                  width: width * 0.08,
                                                  height: width * 0.08,
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
                                                    size: height * 0.020,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),

                                        Positioned(
                                          bottom: height * 0.025,
                                          right: width * 0.03,
                                          child: Container(
                                            height: height * 0.045,
                                            width: width * 0.18,
                                            decoration: ShapeDecoration(
                                              color: Color.fromARGB(
                                                214,
                                                35,
                                                79,
                                                104,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    item["price"],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          color: Colors.white,
                                                          fontSize:
                                                              width * 0.035,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: height * 0.005,
                                                    ),
                                                    child: Text(
                                                      "/month",
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.02,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: width * 0.04,
                                    ),
                                    child: Text(
                                      item["title"],
                                      style: GoogleFonts.raleway(
                                        color: Color(0xFF242B5C),
                                        fontSize: width * 0.05,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  SizedBox(height: height * 0.005),

                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: width * 0.03,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: height * 0.02,
                                        ),
                                        SizedBox(width: width * 0.01),

                                        Text(
                                          item["rating"],
                                          style: GoogleFonts.montserrat(
                                            color: Color(0xFF234F68),
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        SizedBox(width: width * 0.03),

                                        Icon(
                                          Icons.location_on,
                                          size: height * 0.015,
                                          color: Color(0xFF1F4C6B),
                                        ),

                                        SizedBox(width: width * 0.01),

                                        Text(
                                          item["location"],
                                          style: TextStyle(
                                            fontSize: width * 0.025,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1F4C6B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: result.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = result[index];

                          return Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            child: Container(
                              width: width * 0.9,
                              height: height * 0.25,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(186, 244, 242, 242),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.03,
                                            vertical: height * 0.02,
                                          ),
                                          child: Image.asset(
                                            item["image"],
                                            height: height * 0.25,
                                            fit: BoxFit.fill,
                                          ),
                                        ),

                                        // ❤️ Favorite icon (LEFT side like old design)
                                        Positioned(
                                          left: width * 0.05,
                                          top: height * 0.03,
                                          child: Consumer<Createprovider>(
                                            builder: (context, cart, child) {
                                              bool isAdded = cart.isInCart(
                                                item,
                                              );

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
                                                        duration: Duration(
                                                          seconds: 1,
                                                        ),
                                                        backgroundColor:
                                                            Colors.redAccent,
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
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                    milliseconds: 250,
                                                  ),
                                                  width: width * 0.08,
                                                  height: width * 0.08,
                                                  decoration: BoxDecoration(
                                                    color: isAdded
                                                        ? Colors.lightGreen
                                                        : Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    isAdded
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: isAdded
                                                        ? Colors.white
                                                        : Colors.pinkAccent,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),

                                        // 🏠 Apartment button
                                        Positioned(
                                          top: height * 0.165,
                                          left: width * 0.058,
                                          child: SizedBox(
                                            width: width * 0.24,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xFF234F68,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: Text(
                                                "Apartment",
                                                style: GoogleFonts.raleway(
                                                  color: Colors.white,
                                                  fontSize: width * 0.025,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(width: width * 0.02),

                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: height * 0.03,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * 0.35,
                                            child: Text(
                                              item["title"],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: GoogleFonts.raleway(
                                                color: const Color(0xFF234F68),
                                                fontSize: width * 0.045,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 0.54,
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: height * 0.01),

                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: height * 0.02,
                                              ),
                                              SizedBox(width: width * 0.01),
                                              Text(
                                                item["rating"],
                                                style: GoogleFonts.montserrat(
                                                  color: const Color(
                                                    0xFF234F68,
                                                  ),
                                                  fontSize: width * 0.045,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: height * 0.01),

                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: height * 0.020,
                                                color: const Color(0xFF1F4C6B),
                                              ),
                                              SizedBox(width: width * 0.01),
                                              Text(
                                                item["location"],
                                                style: TextStyle(
                                                  fontSize: width * 0.035,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(
                                                    0xFF1F4C6B,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: height * 0.03),

                                          Row(
                                            children: [
                                              Text(
                                                item["price"],
                                                style: GoogleFonts.montserrat(
                                                  color: const Color(
                                                    0xFF234F68,
                                                  ),
                                                  fontSize: width * 0.06,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: height * 0.01,
                                                ),
                                                child: Text(
                                                  " / month",
                                                  style: GoogleFonts.montserrat(
                                                    color: const Color(
                                                      0xFF234F68,
                                                    ),
                                                    fontSize: width * 0.035,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
