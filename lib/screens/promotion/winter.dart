import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class Winter extends StatelessWidget {
  const Winter({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Future<void> shareHalloweenOffer() async {
      await Share.share('''
Winter Sale – Limited Time Offer

Get flat 45% off on your purchase using the promo code below.

Promo Code: JWI1421
Offer Valid Till: November 21,2025

Don't miss this opportunity to save more. Explore the offer now:
https://yourwebsite.com/halloween-offer
''', subject: 'Winter Sale – Flat 40% Off');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.1, top: height * 0.02),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.1, top: height * 0.02),
            child: IconButton(
              icon: Icon(Icons.ios_share, color: Colors.black),
              onPressed: () {
                shareHalloweenOffer();
              },
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.08),
                Center(
                  child:  Stack(
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
                          text: 'Winter \nSale',
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
                        'November 21,2025',
                        style: GoogleFonts.raleway(
                          color: Colors.grey,
                          fontSize: width * 0.035,

                          letterSpacing: 0.54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.04),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: width * 0.07),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.17,
                        height: MediaQuery.of(context).size.height * 0.065,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8BC83D),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Image.asset("assets/coupan.png"),
                      ),
                      SizedBox(width: width * 0.05),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'JWI1421',
                            style: TextStyle(
                              color: const Color(0xFF242B5C),
                              fontSize: width * 0.05, // responsive
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                              letterSpacing: width * 0.0015,
                            ),
                          ),
                          SizedBox(height: width * 0.01), // responsive spacing
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Use this coupon to get ',
                                  style: TextStyle(
                                    color: const Color(0xFF234F68),
                                    fontSize: width * 0.03, // responsive
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: width * 0.0008,
                                  ),
                                ),
                                TextSpan(
                                  text: '45%',
                                  style: TextStyle(
                                    color: const Color(0xFF234F68),
                                    fontSize: width * 0.03, // responsive
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: width * 0.0008,
                                  ),
                                ),
                                TextSpan(
                                  text: ' off on your transaction',
                                  style: TextStyle(
                                    color: const Color(0xFF234F68),
                                    fontSize: width * 0.03, // responsive
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: width * 0.0008,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                Padding(
                  padding: EdgeInsets.all(height * 0.03),
                  child: Text(
                    "The Winter Sale is coming back with even bigger surprises and irresistible offers. This season, we are bringing a spooky twist to your shopping experience with exclusive deals that you simply cannot miss. Whether you are planning to upgrade your essentials or explore new collections, this is the perfect time to shop smart and save more.\n\n\nFrom limited-time discount codes to special combo offers, our Winter Sale is designed to give you maximum value. Unlock exciting price drops across categories and enjoy offers crafted to match your needs. With easy checkout and fast delivery, your festive shopping becomes smoother and more rewarding than ever.\n\n\nGet ready to explore thrilling deals, claim your coupons, and grab the best products before they vanish. The clock is ticking, and these offers will not stay for long. Mark your calendar, stay alert for updates, and make sure you don’t miss the return of our most awaited Winter Sale.",
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF234F68),
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: height * 0.16, // slightly bigger like your design
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white, // 100% white
                    Colors.white, // stronger white
                    Colors.white.withOpacity(0.4), // mid fade
                    Colors.white.withOpacity(0), // fully transparent
                  ],
                  stops: const [0.0, 0.3, 0.6, 1.0], // smooth transition
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8BC83F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: width * 0.59,
                    height: height * 0.07,
                    child: Center(
                      child: Text(
                        "Explore more",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
