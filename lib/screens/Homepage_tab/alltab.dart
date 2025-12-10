import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_esate_finder/screens/register/register.dart';
import 'package:real_esate_finder/screens/promotion/halloween.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:provider/provider.dart';

class Alltab extends StatelessWidget {
  const Alltab({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                      onTap: () {},
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
                      onTap: () {},
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
                      'Featured Estates',
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
                                builder: (context) => Register(),
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
                                    "assets/featured_img2.png",
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
                                    width: width * 0.18,

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
                                        "Villa",
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
                                    'Guru Golden Nest\nVilla',
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
                                        "4.9",
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
                                        "Varkala, KL",
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
                                        '₹\t40k',
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
                                    "assets/featured_img3.png",
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
                                    "assets/featured_img2.png",
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
                                    width: width * 0.18,

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
                                        "Villa",
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
                                    'Guru Golden Nest\nVilla',
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
                                        "4.9",
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
                                        "Varkala, KL",
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
                                        '₹\t40k',
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
                                builder: (context) => Register(),
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

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: width * 0.05),
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/kovai.jpg",
                            width: width * 0.1,
                            height: width * 0.1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          "Coimbatore",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.11),
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/varkala.jpg",
                            width: width * 0.1,
                            height: width * 0.1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          "Varkala",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.11),
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/ooty.jpg",
                            width: width * 0.1,
                            height: width * 0.1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          "Ooty",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.11),
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/chennai.jpg",
                            width: width * 0.1,
                            height: width * 0.1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          "chennai",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.11),
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/cochin.jpg",
                            width: width * 0.1,
                            height: width * 0.1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          "cochin",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.11),
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
                                builder: (context) => Register(),
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

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: width * 0.05),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/person1.png",
                            width: width * 0.2,
                            height: width * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: width * 0.03),
                        Text(
                          "Amanda",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.08),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/person2.png",
                            width: width * 0.2,
                            height: width * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: width * 0.03),
                        Text(
                          "Anderson",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.08),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/person3.png",
                            width: width * 0.2,
                            height: width * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: width * 0.03),
                        Text(
                          "Samantha",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.08),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/person4.png",
                            width: width * 0.2,
                            height: width * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: width * 0.03),
                        Text(
                          "Andrew",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.08),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/person5.png",
                            width: width * 0.2,
                            height: width * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: width * 0.03),
                        Text(
                          "Michael",
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF234F68),
                            fontSize: width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.08),
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
              SizedBox(height: height * 0.02),
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

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "${item['title']} removed from favorites",
                                                ),
                                                duration: Duration(seconds: 1),
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
