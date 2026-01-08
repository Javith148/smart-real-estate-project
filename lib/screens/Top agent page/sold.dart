import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sold extends StatelessWidget {
  const Sold({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> propertyList = [
      {
        "image": "assets/nearby1.png",
        "title": "Wing Tower",
        "price": "₹30k",
        "rating": "4.9",
        "location": "Coimbatore, TN",
      },
      {
        "image": "assets/nearby2.png",
        "title": "Mill  House",
        "price": "₹20k",
        "rating": "4.8",
        "location": "Peelamedu, TN",
      },
      {
        "image": "assets/nearby3.png",
        "title": " The Garden Residency",
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
      {
        "image": "assets/nearby2.png",
        "title": "Mill  House",
        "price": "₹20k",
        "rating": "4.8",
        "location": "Peelamedu, TN",
      },
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.directional(start: width * 0.07),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${propertyList.length}",
                          style: TextStyle(
                            color: const Color(0xFF204D6C),
                            fontSize: width * 0.065,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w900,
                            height: 1.3,
                          ),
                        ),
                        TextSpan(
                          text: ' sold',
                          style: TextStyle(
                            color: const Color(0xFF204D6C),
                            fontSize: width * 0.060,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w300,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: ListView.builder(
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
                                  padding: EdgeInsets.only(top: height * 0.03),
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
                                                color: const Color(0xFF234F68),
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




      )   
        
    );
  }
}
