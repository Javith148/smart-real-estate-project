import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:provider/provider.dart';

class Locationdetail extends StatefulWidget {
  final Map<String, dynamic> item;
  final int index;

  const Locationdetail({super.key, required this.item, required this.index});

  @override
  State<Locationdetail> createState() => _LocationdetailState();
}

class _LocationdetailState extends State<Locationdetail> {
  bool isGridView = true;

  List<Map<String, dynamic>> propertyList = [
    {
      "image": "assets/nearby1.png",
      "title": "Wings Tower",
      "price": "₹30k",
      "rating": "4.9",
      "location": "Coimbatore, TN",
    },
    {
      "image": "assets/nearby2.png",
      "title": "Mill Sper House",
      "price": "₹20k",
      "rating": "4.8",
      "location": "Peelamedu, TN",
    },
    {
      "image": "assets/nearby3.png",
      "title": "Garden Residency",
      "price": "₹25k",
      "rating": "4.7",
      "location": "RS Puram, TN",
    },
    {
      "image": "assets/nearby4.png",
      "title": "Elite Apartment",
      "price": "₹28k",
      "rating": "4.9",
      "location": "Saibaba Colony, TN",
    },
  ];
  
 int get listcounter => propertyList.length;
  late FocusNode _focusNode;
  Timer? _keyboardTimer;

  bool selectedHouse = false;
  bool selectedApartment = false;
  bool selectedVilla = false;
  String selectedPriceSort = "";

  Future<void> openFilters() async {
    final result = await openFilterSheet(context);

    if (result != null) {
      setState(() {
        selectedHouse = result["house"];
        selectedApartment = result["apartment"];
        selectedVilla = result["villa"];
        selectedPriceSort = result["priceSort"];
      });
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
                weight: 900,
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
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _startKeyboardTimer();
      } else {
        _keyboardTimer?.cancel();
      }
    });
  }

  void _startKeyboardTimer() {
    _keyboardTimer?.cancel();

    _keyboardTimer = Timer(const Duration(seconds: 5), () {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _keyboardTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final String mainImage = widget.item["image"];

    final String sub1Image = widget.item["sub1"] ?? mainImage;
    final String sub2Image = widget.item["sub2"] ?? mainImage;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.directional(
                start: width * 0.05,
                end: width * 0.05,
                top: width * 0.09,
                bottom: height * 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(15),
                            ),
                            child: SizedBox(
                              width: width * 0.60,
                              height: width * 0.85,
                              child: Image.asset(
                                widget.item["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.directional(
                              start: width * 0.03,
                              top: height * 0.02,
                            ),
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
                            bottom: height * 0.015,
                            left: width * 0.028,
                            child: Container(
                              width: width * 0.13,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "#",
                                        style: GoogleFonts.montserrat(
                                          fontSize: width * 0.030,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${widget.index + 1}",
                                        style: GoogleFonts.montserrat(
                                          fontSize: width * 0.045,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: width * 0.03),

                      SizedBox(
                        height: width * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(40),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  child: SizedBox(
                                    width: width * 0.27,
                                    height: width * 0.55,
                                    child: Image.asset(
                                      sub1Image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.directional(
                                    start: width * 0.11,
                                    top: height * 0.02,
                                  ),
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
                              ],
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(40),
                              ),
                              child: SizedBox(
                                width: width * 0.27,
                                height: width * 0.25,
                                child: Image.asset(
                                  sub2Image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                   
                    ],
                  ),
                  SizedBox(height: height * 0.045),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item['title'],
                          style: GoogleFonts.lato(
                            color: const Color(0xFF242B5C),
                            fontSize: width * 0.08,
                            fontWeight: FontWeight.w900,
                            height: 1.5,
                            letterSpacing: 0.36,
                          ),
                        ),

                        Text(
                          "Our recommended real estates in ${widget.item['title']}",
                          style: GoogleFonts.raleway(
                            color: Colors.grey,
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 0.85,
                          child: TextFormField(
                            autofocus: false,
                            focusNode: _focusNode,
                            onChanged: (_) => _startKeyboardTimer(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,

                              contentPadding: EdgeInsets.symmetric(
                                vertical: height * 0.025,
                                horizontal: width * 0.04,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: const Color(0xFF242B5C),
                                  width: 1.5,
                                ),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),

                              labelText: "Search Home, Apartment, etc",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              suffixIcon: const Icon(Icons.search),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(start: width * 0.08),
              child: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Found ',
                          style: TextStyle(
                            color: const Color(0xFF204D6C),
                            fontSize: width * 0.060,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                        TextSpan(
                          text: "$listcounter",
                          style: TextStyle(
                            color: const Color(0xFF204D6C),
                            fontSize: width * 0.065,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w900,
                            height: 1.3,
                          ),
                        ),
                        TextSpan(
                          text: ' estate',
                          style: TextStyle(
                            color: const Color(0xFF204D6C),
                            fontSize: width * 0.060,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: width * 0.3),
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
            SizedBox(height: height * 0.02),
            if (selectedHouse ||
                selectedApartment ||
                selectedVilla ||
                selectedPriceSort.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (selectedHouse)
                        filterChip("House", () {
                          setState(() => selectedHouse = false);
                        }),

                      if (selectedApartment)
                        filterChip("Apartment", () {
                          setState(() => selectedApartment = false);
                        }),

                      if (selectedVilla)
                        filterChip("Villa", () {
                          setState(() => selectedVilla = false);
                        }),

                      if (selectedPriceSort.isNotEmpty)
                        filterChip(
                          selectedPriceSort == "low"
                              ? "Low to High"
                              : "High to Low",
                          () {
                            setState(() => selectedPriceSort = "");
                          },
                        ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.05),
              child: isGridView
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: (width * 0.45) / (height * 0.32),
                      ),

                      itemCount: propertyList.length,

                      itemBuilder: (context, index) {
                        final item = propertyList[index];

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
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontSize: width * 0.035,
                                                    fontWeight: FontWeight.w700,
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
                                  padding: EdgeInsets.only(left: width * 0.04),
                                  child: Text(
                                    item["title"],
                                    style: GoogleFonts.raleway(
                                      color: Color(0xFF242B5C),
                                      fontSize: width * 0.05,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),

                                SizedBox(height: height * 0.005),

                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.03),
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
                      itemCount: propertyList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = propertyList[index];

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
                                        Text(
                                          "${item["title"]}\nApartment",
                                          style: GoogleFonts.raleway(
                                            color: const Color(0xFF234F68),
                                            fontSize: width * 0.045,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.54,
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
                                                color: const Color(0xFF234F68),
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
                                                color: const Color(0xFF1F4C6B),
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
                                                color: const Color(0xFF234F68),
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
      drawer: DrawerButton(),
    );
  }
}
