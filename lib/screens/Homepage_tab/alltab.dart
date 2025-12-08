import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_esate_finder/screens/register/register.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:provider/provider.dart';

class Alltab extends StatelessWidget {
  const Alltab({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final username = context.watch<Createprovider>().username;
    final mail = context.watch<Createprovider>().mailid;
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
                      onTap: () {},
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.04),
                    Container(
                      width: width * 0.8,
                      height: height * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                            child: Image.asset("assets/featured_img.png",height: height *1,width: width*0.5,),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Container(
                      width: width * 0.8,
                      height: height * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
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
  }
}
