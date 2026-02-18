import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_esate_finder/cartpage.dart';
import 'package:real_esate_finder/screens/promotion/halloween.dart';
import 'package:real_esate_finder/screens/promotion/summer.dart';
import 'package:real_esate_finder/screens/promotion/Winter.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/screens/property_details/property_details.dart';
import 'package:real_esate_finder/screens/topLocation/topLocation.dart';
import 'package:real_esate_finder/screens/topLocation/locationdetail.dart';
import 'package:real_esate_finder/screens/top agent page/agent.dart';
import 'package:real_esate_finder/screens/top agent page/agentprofile.dart';

class Alltab extends StatelessWidget {
  const Alltab({super.key});

  Widget featuredEstateCard({
    required double width,
    required double height,
    required Map item,
  }) {
    String getPropertyType(String title) {
      final lower = title.toLowerCase();

      if (lower.contains("villa")) return "Villa";
      if (lower.contains("house")) return "House";
      if (lower.contains("apartment")) return "Apartment";

      return "Property";
    }

    return Container(
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
                Positioned(
                  left: width * 0.052,
                  top: height * 0.032,
                  child: Container(
                    width: width * 0.08,
                    height: width * 0.08,
                    decoration: const BoxDecoration(
                      color: Color(0xFF8BC83F),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: height * 0.015,
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.165,
                  left: width * 0.058,
                  child: SizedBox(
                    width: width * 0.24,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF234F68),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        getPropertyType(item["title"]),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"],
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
                        item["rating"] ?? "4.2",
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
                        item["location"] ?? "Coimbatore, TN",
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
                        item["price"], // ✅ NO EXTRA ₹
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF234F68),
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.01),
                        child: Text(
                          "/month",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Createprovider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> propertyList = [
      {
        "image": "assets/nearby1.png",
        "title": "Wings Tower",
        "price": "₹ 30k",
        "rating": "4.9",
        "property-type": "Apartment",
        "location": "Coimbatore, TN",
        "cost_of_living": "5000",
        "agent": {
          "name": "Javi",
          "mail id": "javithjavi@gmail.com",
          "image": "assets/person_javi.jpeg",
          "rating": "5",
          "sold": "500",
          "reviews": "1000",
        },
        "property-rooms": {
          'bedrooms': '4',
          'bathroom': '2',
          'kitchen': '1',
          "store_room": '1',
          "balcony": '2',
        },

      },
      {
        "image": "assets/nearby2.png",
        "title": "Mill Sper House",
        "price": "₹ 20k",
        "rating": "2.5",
        "property-type": "House",
        "location": "Peelamedu,TN",
        "cost_of_living": "9000",
        "agent": {
          "name": "Amanda",
          "mail id": "javithjavi@gmail.com",
          "image": "assets/person1.png",
          "rating": "4.5",
          "sold": "124",
          "reviews": "400",
        },
        "property-rooms": {
          "bedrooms": '2',
          "bathroom": '2',
          "kitchen": '1',
          "store_room": '0',
          "balcony": '1',
        },
      },
      {
        "image": "assets/nearby3.png",
        "title": "Garden Residency",
        "price": "₹ 25k",
        "rating": "4.7",
        "property-type": "Apartment",
        "location": "RS Puram, TN",
        "cost_of_living": "10000",
        "agent": {
          "name": "Anderson",
          "mail id": "javithjavi@gmail.com",
          "image": "assets/person2.png",
          "rating": "4",
          "sold": "124",
          "reviews": "180",
        },
        "property-rooms": {
          "bedrooms": '3',
          "bathroom": '3',
          "kitchen": '1',
          "store_room": '1',
          "balcony": '2',
        },
      },
      {
        "image": "assets/nearby4.png",
        "title": "Elite Apartment",
        "price": "₹ 28k",
        "rating": "4.9",
        "property-type": "Apartment",
        "location": "Saibaba Colony, TN",
        "cost_of_living": "7000",
        "agent": {
          "name": "Samantha",
          "mail id": "javithjavi@gmail.com",
          "image": "assets/person3.png",
          "rating": "4",
          "sold": "124",
          "reviews": "440",
        },
        "property-rooms": {
          "bedrooms": '1',
          "bathroom": '1',
          "kitchen": '1',
          "store_room": '0',
          "balcony": '1',
        },
      },
      {
        "image": "assets/nearby4.png",
        "title": "Elite Apartment",
        "price": "₹ 28k",
        "rating": "4.9",
        "property-type": "Apartment",
        "location": "Selvapuram, TN",
        "cost_of_living": "9000",
        "agent": {
          "name": "Michael",
          "mail id": "javithjavi@gmail.com",
          "image": "assets/person5.png",
          "rating": "4",
          "sold": "124",
          "reviews": "340",
        },
        "property-rooms": {
          "bedrooms": '4',
          "bathroom": '4',
          "kitchen": '1',
          "store_room": '2',
          "balcony": '3',
        },
      },
    ];

    List<Map<String, dynamic>> loaction = [
      {
        "image": "assets/kovai.jpg",
        "title": "Coimbatore",
        "sub1": "assets/kovai1.jpg",
        "sub2": "assets/kovai2.jpg",
      },
      {
        "image": "assets/chennai.jpg",
        "title": "Chennai",
        "sub1": "assets/chennai2.jpg",
        "sub2": "assets/chennai1.jpg",
      },
      {
        "image": "assets/ooty.jpg",
        "title": "Ooty",
        "sub1": "assets/ooty1.jpg",
        "sub2": "assets/ooty2.jpg",
      },
      {
        "image": "assets/cochin.jpg",
        "title": "Cochin",
        "sub1": "assets/cochin1.jpg",
        "sub2": "assets/cochin2.jpg",
      },
      {
        "image": "assets/varkala.jpg",
        "title": "Varkala",
        "sub1": "assets/varkala1.jpg",
        "sub2": "assets/varkala2.jpg",
      },
      {
        "image": "assets/bangalore.jpg",
        "title": "Bangalore",
        "sub1": "assets/bangalore1.jpg",
        "sub2": "assets/bangalore2.jpg",
      },
    ];

    final List<Map<String, String>> peopleList = [
      {
        "name": "Javi",
        "mail id": "javithjavi@gmail.com",
        "image": "assets/person_javi.jpeg",
        "rating": "5",
        "sold": "500",
        "reviews": "1000",
      },
      {
        "name": "Amanda",
        "mail id": "javithjavi@gmail.com",
        "image": "assets/person1.png",
        "rating": "4.5",
        "sold": "124",
        "reviews": "400",
      },
      {
        "name": "Anderson",
        "mail id": "javithjavi@gmail.com",
        "image": "assets/person2.png",
        "rating": "4",
        "sold": "124",
        "reviews": "180",
      },
      {
        "name": "Samantha",
        "mail id": "javithjavi@gmail.com",
        "image": "assets/person3.png",
        "rating": "4",
        "sold": "124",
        "reviews": "440",
      },
      {
        "name": "Andrew",
        "mail id": "javithjavi@gmail.com",
        "image": "assets/person4.png",
        "rating": "4",
        "sold": "124",
        "reviews": "102",
      },
      {
        "name": "Michael",
        "mail id": "javithjavi@gmail.com",
        "image": "assets/person5.png",
        "rating": "4",
        "sold": "124",
        "reviews": "340",
      },
    ];

    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.04),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Halloween()),
                        );
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/tab_img.png",
                            fit: BoxFit.cover,
                            width: width * 0.725,
                            height: height * 0.225,
                          ),
                          Opacity(
                            opacity: 0.30,
                            child: Container(
                              width: width * 0.725,
                              height: height * 0.225,
                              decoration: ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.175,
                            child: Container(
                              width: width * 0.22,
                              height: height * 0.05,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF234F68),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_right_alt,
                                  color: Colors.white,
                                  size: height * 0.03,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.4,
                            height: height * 0.2,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: width * 0.05,
                                  top: height * 0.05,
                                  child: Text(
                                    'Halloween \nSale!',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: width * 0.059,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.54,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.05,
                                  top: height * 0.115,
                                  child: Text(
                                    'All discount up to 60%',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Summer()),
                        );
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              "assets/tab_img2.png",
                              fit: BoxFit.cover,
                              width: width * 0.725,
                              height: height * 0.225,
                            ),
                          ),

                          Opacity(
                            opacity: 0.30,
                            child: Container(
                              width: width * 0.725,
                              height: height * 0.225,
                              decoration: ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.175,
                            child: Container(
                              width: width * 0.22,
                              height: height * 0.05,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF234F68),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_right_alt,
                                  color: Colors.white,
                                  size: height * 0.03,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.4,
                            height: height * 0.2,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: width * 0.05,
                                  top: height * 0.05,
                                  child: Text(
                                    'Summer\nVacation',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: width * 0.059,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.54,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.05,
                                  top: height * 0.115,
                                  child: Text(
                                    'All discount up to 80%',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Winter()),
                        );
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              "assets/tab_img3.png",
                              fit: BoxFit.cover,
                              width: width * 0.725,
                              height: height * 0.225,
                            ),
                          ),
                          Opacity(
                            opacity: 0.30,
                            child: Container(
                              width: width * 0.725,
                              height: height * 0.225,
                              decoration: ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.175,
                            child: Container(
                              width: width * 0.22,
                              height: height * 0.05,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF234F68),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_right_alt,
                                  color: Colors.white,
                                  size: height * 0.03,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.4,
                            height: height * 0.2,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: width * 0.05,
                                  top: height * 0.05,
                                  child: Text(
                                    'winter is \nComing!',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: width * 0.059,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.54,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.05,
                                  top: height * 0.115,
                                  child: Text(
                                    'All discount up to 45%',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                  ],
                ),
              ),
              SizedBox(height: height * 0.011),
              Padding(
                padding: EdgeInsetsGeometry.directional(
                  start: width * 0.07,
                  end: width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Favourite',
                      style: TextStyle(
                        color: const Color(0xFF242B5C),
                        fontSize: width * 0.060,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.54,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: height * 0.005),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cartpage(),
                              ),
                            );
                          },
                          child: Text(
                            'view all',
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF242B5C),
                              fontSize: width * 0.039,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: width * 0.04),
                    Container(
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
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: width * 0.03,
                                    vertical: height * 0.02,
                                  ),
                                  child: Image.asset(
                                    "assets/featured_img.png",
                                    height: height * 0.25,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.052,
                                  top: height * 0.032,
                                  child: Container(
                                    width: width * 0.08,
                                    height: width * 0.08,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF8BC83F),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: height * 0.015,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: height * 0.165,
                                  left: width * 0.058,
                                  child: Container(
                                    width: width * 0.24,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        backgroundColor: const Color(
                                          0xFF234F68,
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
                              padding: EdgeInsetsGeometry.only(
                                top: height * 0.03,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sky Dandelions\nApartment',
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
                                        "4.2",
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: height * 0.020,
                                        color: const Color(0xFF1F4C6B),
                                      ),
                                      SizedBox(width: width * 0.01),
                                      Text(
                                        "Coimbatore, TN",
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
                                        '₹\t20k',
                                        style: GoogleFonts.montserrat(
                                          color: const Color(0xFF234F68),
                                          fontSize: width * 0.06,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsGeometry.only(
                                          top: height * 0.01,
                                        ),
                                        child: Text(
                                          '/month',
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
                    SizedBox(width: width * 0.04),

                    ...cart.cartItems.take(4).map((item) {
                      return Padding(
                        padding: EdgeInsets.only(right: width * 0.04),
                        child: featuredEstateCard(
                          width: width,
                          height: height,
                          item: item,
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              SizedBox(height: height * 0.011),
              //top loction title
              Padding(
                padding: EdgeInsetsGeometry.directional(
                  start: width * 0.07,
                  end: width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Locations',
                      style: TextStyle(
                        color: const Color(0xFF242B5C),
                        fontSize: width * 0.060,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.54,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: height * 0.005),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Toplocation(),
                              ),
                            );
                          },
                          child: Text(
                            'explore',
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF242B5C),
                              fontSize: width * 0.039,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.013),

              // top loction list
              Padding(
                padding: EdgeInsetsGeometry.directional(start: width * 0.05),
                child: SizedBox(
                  height: width * 0.15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    itemCount: loaction.length > 5 ? 5 : loaction.length,

                    padding: EdgeInsets.only(left: width * 0.02),
                    itemBuilder: (context, index) {
                      final item = loaction[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Locationdetail(item: item, index: index),
                            ),
                          );
                        },

                        child: Padding(
                          padding: EdgeInsets.only(right: width * 0.11),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  item["image"],
                                  width: width * 0.1,
                                  height: width * 0.1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: width * 0.03),
                              Text(
                                item["title"],
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF234F68),
                                  fontSize: width * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              //top agent heading
              SizedBox(height: height * 0.011),
              Padding(
                padding: EdgeInsetsGeometry.directional(
                  start: width * 0.07,
                  end: width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Estate Agent',
                      style: TextStyle(
                        color: const Color(0xFF242B5C),
                        fontSize: width * 0.060,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.54,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: height * 0.005),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TopAgent(peopleList: peopleList),
                              ),
                            );
                          },

                          child: Text(
                            'explore',
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF242B5C),
                              fontSize: width * 0.039,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.013),
              //top agent list
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: SizedBox(
                  height: width * 0.35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: peopleList.length > 5 ? 6 : peopleList.length,

                    itemBuilder: (context, index) {
                      final detail = peopleList[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Agentprofile(
                                peopleList: peopleList,
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: width * 0.11),
                          child: Column(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  detail["image"]!,
                                  width: width * 0.2,
                                  height: width * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: width * 0.03),
                              Text(
                                detail["name"]!,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF234F68),
                                  fontSize: width * 0.05,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: height * 0.011),

              // nearest estate title
              Padding(
                padding: EdgeInsetsGeometry.directional(
                  start: width * 0.07,
                  end: width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore Nearby Estates',
                      style: TextStyle(
                        color: const Color(0xFF242B5C),
                        fontSize: width * 0.060,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.54,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.0),
              //nearest estate
              GridView.builder(
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PropertyDetails(property: item),
                          ),
                        );
                      },

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
                                        color: Color.fromARGB(214, 35, 79, 104),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
