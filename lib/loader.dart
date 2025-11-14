import 'package:flutter/material.dart';
import 'package:real_esate_finder/screens/loader/page1.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/Loader_img.png",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Opacity(
            opacity: 0.5,
            child: Container(color: const Color(0xCC21628A)),
          ),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.cover,
                        width: 250,
                        height: 250,
                      ),

                      Positioned(
                        top: 180,
                        left: 30,
                        child: Text(
                          'Smart \nReal Estate\n',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 190,
                        height: 50,
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
                                builder: (context) => LoadPage1(),
                              ),
                            );
                          },
                          child: const Text(
                            "Let's Start",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.48,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Made with love\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.30,
                              ),
                            ),
                            TextSpan(
                              text: 'v.1.0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.30,
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
