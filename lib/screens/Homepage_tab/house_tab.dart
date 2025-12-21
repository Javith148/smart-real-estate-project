import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:provider/provider.dart';

class HouseTab extends StatefulWidget {
  const HouseTab({super.key});

  @override
  State<HouseTab> createState() => _HouseTabState();
}

class _HouseTabState extends State<HouseTab> {


  @override
  Widget build(BuildContext context) {
    
 final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    
    List<Map<String, dynamic>> propertyList = [
      {
        "image": "assets/nearby1.png",
        "title": "Row house",
        "price": "₹30k",
        "rating": "4.9",
        "location": "Coimbatore, TN",
      },
      {
        "image": "assets/nearby2.png",
        "title": "Sper House",
        "price": "₹20k",
        "rating": "4.8",
        "location": "Peelamedu, TN",
      },
      {
        "image": "assets/nearby3.png",
        "title": "Garden house",
        "price": "₹25k",
        "rating": "4.7",
        "location": "RS Puram, TN",
      },
      {
        "image": "assets/nearby4.png",
        "title": "Elite house",
        "price": "₹28k",
        "rating": "4.9",
        "location": "Saibaba Colony, TN",
      },
      {
        "image": "assets/tab_img.png",
        "title": "old house",
        "price": "₹28k",
        "rating": "4.9",
        "location": "Saibaba Colony, TN",
      },
      {
        "image": "assets/tab_img2.png",
        "title": "grand house",
        "price": "₹28k",
        "rating": "4.9",
        "location": "Saibaba Colony, TN",
      },
    ];


    return SafeArea(
      child: GridView.builder(
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
                          child: Consumer<CartProvider>(
                            builder: (context, cart, child) {
                              bool isAdded = cart.isInCart(item);

                              return InkWell(
                                onTap: () {
                                  if (isAdded) {
                                    cart.removeFromCart(item);

                                    ScaffoldMessenger.of(context).showSnackBar(
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

                                    ScaffoldMessenger.of(context).showSnackBar(
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
                              color: Color.fromARGB(214, 35, 79, 104),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: width * 0.02,
                                        fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
