import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQpage extends StatefulWidget {
  const FAQpage({super.key});

  @override
  State<FAQpage> createState() => _FAQpageState();
}

class _FAQpageState extends State<FAQpage> {
  void launchWebsite() async {
    const url = 'https://www.google.com';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'FAQ',
                        style: TextStyle(
                          color: const Color(0xFF1F4C6B),
                          fontSize: 30,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          height: 1.60,
                          letterSpacing: 0.75,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: const Color(0xFF242B5C),
                          fontSize: 30,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          height: 1.60,
                          letterSpacing: 0.75,
                        ),
                      ),
                      TextSpan(
                        text: '&',
                        style: TextStyle(
                          color: const Color(0xFF242B5C),
                          fontSize: 30,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          height: 1.60,
                          letterSpacing: 0.75,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: const Color(0xFF242B5C),
                          fontSize: 30,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          height: 1.60,
                          letterSpacing: 0.75,
                        ),
                      ),
                      TextSpan(
                        text: 'Support',
                        style: TextStyle(
                          color: const Color(0xFF1F4C6B),
                          fontSize: 30,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          height: 1.60,
                          letterSpacing: 0.75,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Find answer to your problem using this app.',
                  style: TextStyle(
                    color: const Color(0xFF53577A),
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w400,
                    height: 1.67,
                    letterSpacing: 0.36,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 328,
                  height: 300,
                  child: Stack(
                    children: [
                      Container(
                        width: 328,
                        height: 238,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: launchWebsite,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF1F4C6B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.language,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),

                                    const Text(
                                      'Visit our website',
                                      style: TextStyle(
                                        color: Color(0xFF242B5C),
                                        fontSize: 16,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 1.67,
                                        letterSpacing: 0.36,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        left: 0,
                        top: 64,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.mail,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF1F4C6B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 9,
                                    top: 9,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      child: Stack(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Email us',
                              style: TextStyle(
                                color: const Color(0xFF242B5C),
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                                height: 1.67,
                                letterSpacing: 0.36,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 128,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      child: Icon(
                                        Icons.edit_document,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      width: 40,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF1F4C6B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 9,
                                    top: 9,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      child: Stack(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Terms of service',
                              style: TextStyle(
                                color: const Color(0xFF242B5C),
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                                height: 1.67,
                                letterSpacing: 0.36,
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
            Container(
              width: 327,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F4F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Try find “how to”',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A4C1),
                      fontSize: 12,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.36,
                    ),
                    prefixIcon: Icon(
                      Icons.search, // 🔍 search icon
                      color: Color(0xFFA1A4C1),
                      size: 20,
                    ),
                    border: InputBorder.none, // remove default underline
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
