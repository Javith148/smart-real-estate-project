import 'package:flutter/material.dart';
import 'package:real_esate_finder/main_login.dart';
import 'package:real_esate_finder/screens/loader/page3.dart';

class LoadPage2 extends StatelessWidget {
  const LoadPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---------- TOP ROW ----------
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/logo.png", width: width * 0.18),

                SizedBox(
                  width: width * 0.22,
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDFDFDF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FAQpage()),
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.030,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: height * 0.03),

          /// ---------- MAIN TITLE ----------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Fast sell your property \nin just ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.075,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  TextSpan(
                    text: 'one click',
                    style: TextStyle(
                      color: const Color(0xFF204D6C),
                      fontSize: width * 0.075,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: height * 0.015),

          /// ---------- SUBTITLE ----------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur \nadipiscing elit, sed.',
              style: TextStyle(
                color: const Color(0xFF292929),
                fontSize: width * 0.035,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),

          SizedBox(height: height * 0.03),

          /// ---------- IMAGE FULL HEIGHT WITH SMALL PADDING ----------
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.002),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/load_img2.png",
                      width: width,
                      height: height * 0.60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: height * 0.50, // 50% from top
                    left: width * 0.35, // 25% from left
                    width: width * 0.38, // 40% of screen width
                    height: height * 0.06, // 7% height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8BC83F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>LoadPage3()),
                        );
                      },
                      child: const Text(
                        "Next",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: height * 0.50, // 45% from top (adjust if needed)
                    left: width * 0.15, // 10% from left
                    child: Container(
                      height: width * 0.13, // circle size responsive
                      width: width * 0.13, // circle size responsive
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: width * 0.06, // icon responsive
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),

                  /// Progress Bar Background
                  Positioned(
                    top: height * 0.48,
                    left: width * 0.44,
                    child: Container(
                      height: height * 0.005,
                      width: width * 0.20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9B9999),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  /// Progress Bar Filled Part
                  Positioned(
                    top: height * 0.48,
                    left: width * 0.44,
                    child: Container(
                      height: height * 0.005,
                      width: width * 0.10,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E1E1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
