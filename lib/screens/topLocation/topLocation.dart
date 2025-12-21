import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Toplocation extends StatelessWidget {
  const Toplocation({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    List<Map<String, dynamic>> propertyList = [
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: height * 0.09,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.09, top: height * 0.03),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            left: width * 0.05,
            right: width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              Text(
                "Top Locations",
                style: TextStyle(
                  color: Color(0xFF242B5C),
                  fontSize: width * 0.080,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                "Find the best recommendations place to live",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.04),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: (width * 0.45) / (height * 0.3),
                ),

                itemCount: propertyList.length,

                itemBuilder: (context, index) {
                  final item = propertyList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationDeatil(
                            item: propertyList[index],
                            index: index,
                          ),
                        ),
                      );
                    },

                    child: Card(
                      child: Container(
                        width: width * 0.45,
                        height: height * 0.3,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(186, 244, 242, 242),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.02),
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: width * 0.35,
                                    height: width * 0.45,
                                    child: Image.asset(
                                      item["image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.directional(
                                    start: width * 0.02,
                                    top: height * 0.01,
                                  ),
                                  child: Container(
                                    width: width * 0.065,
                                    height: height * 0.035,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "#",
                                              style: GoogleFonts.montserrat(
                                                fontSize: width * 0.025,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${index + 1}",
                                              style: GoogleFonts.montserrat(
                                                fontSize: width * 0.035,
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
                            SizedBox(height: height * 0.015),
                            Padding(
                              padding: EdgeInsetsGeometry.directional(
                                start: width * 0.06,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    item["title"],
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF242B5C),
                                      fontSize: width * 0.032,
                                      fontWeight: FontWeight.w700,
                                      height: 1.5,
                                      letterSpacing: 0.36,
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

class LocationDeatil extends StatelessWidget {
  final Map<String, dynamic> item;
  final int index;
  const LocationDeatil({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final String mainImage = item["image"];

    final String sub1Image = item["sub1"] ?? mainImage;
    final String sub2Image = item["sub2"] ?? mainImage;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.05,
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
                          child: Image.asset(item["image"], fit: BoxFit.cover),
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
                                    text: "${index + 1}",
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
                            child: Image.asset(sub2Image, fit: BoxFit.cover),
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
                      item['title'],
                      style: GoogleFonts.lato(
                        color: const Color(0xFF242B5C),
                        fontSize: width * 0.08,
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        letterSpacing: 0.36,
                      ),
                    ),

                    Text(
                      "Our recommended real estates in ${item['title']}",
                      style: GoogleFonts.raleway(
                        color: Colors.grey,
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w700,
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
