import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Halloween extends StatelessWidget {
  const Halloween({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.1, top: height * 0.02),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.1, top: height * 0.02),
            child: IconButton(icon: Icon(Icons.ios_share), onPressed: () {}),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.08),
          Center(
            child: Stack(
              children: [
                Image.asset(
                  "assets/tab_img.png",
                  fit: BoxFit.contain,
                  width: width * 0.8,
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

          SizedBox(height: height * 0.03),
          Padding(
            padding: EdgeInsetsGeometry.only(left: width * 0.06),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Limited time ',
                    style: TextStyle(
                      color: const Color(0xFF204D6C),
                      fontSize: width * 0.075,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: height * 0.0014,
                    ),
                  ),
                  TextSpan(
                    text: 'Halloween \nSale',
                    style: TextStyle(
                      color: const Color(0xFF204D6C),
                      fontSize: width * 0.075,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w900,
                      height: height * 0.0014,
                    ),
                  ),
                  TextSpan(
                    text: ' is coming back! ',
                    style: TextStyle(
                      color: const Color(0xFF204D6C),
                      fontSize: width * 0.075,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: height * 0.0014,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.03),
          Padding(
            padding: EdgeInsetsGeometry.only(left: width * 0.06),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: height * 0.015,
                  color: const Color.fromARGB(255, 3, 154, 181),
                ),
                Text(
                  'October 31,2025',
                  style: GoogleFonts.raleway(
                    color: Colors.grey,
                    fontSize: width * 0.035,
                    
                    letterSpacing: 0.54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
