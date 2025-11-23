import 'package:flutter/material.dart';
import 'package:real_esate_finder/screens/login/mailLogin.dart';
import 'package:real_esate_finder/screens/register/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.035),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/login_img.png",
                  width: width * 0.44,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/login_img2.png",
                  width: width * 0.44,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/login_img3.png",
                  width: width * 0.44,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/login_img4.png",
                  width: width * 0.44,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.065),

          Padding(
            padding: EdgeInsets.only(left: width * 0.08),
            child: Row(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Ready to",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: width * 0.070,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF1F4C6B),
                        ),
                      ),

                      TextSpan(
                        text: "\texplore ?",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: width * 0.070,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F4C6B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.045),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8BC83F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Maillogin()),
              );
            },
            child: SizedBox(
              width: width * 0.59,
              height: height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mail_outline_outlined,
                    size: height * 0.025,
                    color: Colors.white,
                  ),
                  SizedBox(width: width * 0.02),
                  Text(
                    "Continue with Email",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          Center(
            child: Stack(
              children: [
                Positioned(
                  top: height * 0.015,
                  left: height * 0.035,
                  right: height * 0.035,
                  child: Container(
                    width: width * 0.85,
                    height: height * 0.0005,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: Container(
                    height: height * 0.03,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "or",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Raleway',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.09,
              vertical: height * 0.045,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    width: width * 0.38,
                    height: height * 0.08,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 239, 239, 240),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/google_icon.png",
                            width: width * 0.08,
                            height: height * 0.08,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: width * 0.38,
                    height: height * 0.08,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 239, 239, 240),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/facebook.png",
                            width: width * 0.08,
                            height: height * 0.08,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.035),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.w500,
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: const Color(0xFF1F4C6B),
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.bold,
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
