import 'package:flutter/material.dart';
import 'package:real_esate_finder/main_login.dart';

class LoadPage3 extends StatelessWidget {
  const LoadPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50.5),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Image.asset("assets/logo.png", width: 100, height: 100),
              ),
              const SizedBox(width: 190),
              ElevatedButton(
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
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    height: 1.83,
                    letterSpacing: 0.36,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: SizedBox(
              width: 700,
              height: 70,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Find',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 0.60,
                        letterSpacing: 0.75,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: const Color(0xFF204D6C),
                        fontSize: 30,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.60,
                        letterSpacing: 0.75,
                      ),
                    ),
                    TextSpan(
                      text: 'perfect choice ',
                      style: TextStyle(
                        color: const Color(0xFF204D6C),
                        fontSize: 30,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        height: 1.60,
                        letterSpacing: 0.75,
                      ),
                    ),

                    TextSpan(
                      text: 'for \nyour future house ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1,
                        letterSpacing: 0.75,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur \nadipiscing elit, sed.',
              style: TextStyle(
                color: const Color(0xFF292929),
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                height: 1.67,
                letterSpacing: 0.36,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 7, top: 30),
            child: Stack(
              children: [
                Image.asset(
                  "assets/load_img3.png",
                  width: 450,
                  height: 510,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: 400,
                  left: 100,
                  width: 170,
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
                        MaterialPageRoute(builder: (context) => FAQpage()),
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
                        letterSpacing: 0.48,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 400,
                  left: 40,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                ),

                Positioned(
                  top: 380,
                  left: 130,
                  child: Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(211, 155, 153, 153),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 380,
                  left: 130,
                  child: Container(
                    height: 5,
                    width: 90,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(210, 229, 225, 225),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
