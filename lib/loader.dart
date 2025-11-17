import 'package:flutter/material.dart';
import 'package:real_esate_finder/screens/loader/page1.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Responsive title size
    double titleSize = width < 360
        ? 28
        : width < 600
        ? 35
        : 45;

    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          Image.asset(
            "assets/Loader_img.png",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),

          /// Color Overlay
          Opacity(
            opacity: 0.5,
            child: Container(color: const Color(0xCC21628A)),
          ),

          /// Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x0021628A), Color.fromARGB(227, 31, 77, 107)],
                  stops: [0.5, 0.8],
                ),
              ),
            ),
          ),

          /// Center Logo + Text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, -height * 0.10), // Moves up
                child: Center(
                  child: SizedBox(
                    height: height * 0.35,
                    width: width * 0.55,
                    child: Stack(
                      alignment: Alignment.center, 
                      children: [
                        /// Logo Image
                        Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.cover,
                          width: width * 0.45,
                          height: height * 0.25,
                        ),

                        /// PERFECT CENTERED TEXT ✔
                        Positioned(
                          top: height * 0.23,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              'Smart \nReal Estate',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: titleSize,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                              ),
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

          /// Bottom Button + Version Info
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      // Responsive Button
                      SizedBox(
                        width: width * 0.40,
                        height: height * 0.06,
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
                              MaterialPageRoute(
                                builder: (context) => const LoadPage1(),
                              ),
                            );
                          },
                          child: Text(
                            "Let's Start",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.05,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Version Info
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Made with love\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'v.1.0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
