import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:real_esate_finder/homepage.dart';
import 'dart:async';

class OtpPage extends StatefulWidget {
  final String otp;
  const OtpPage({super.key, required this.otp});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // CONTROLLERS
  final field1 = TextEditingController();
  final field2 = TextEditingController();
  final field3 = TextEditingController();
  final field4 = TextEditingController();

  // FOCUS NODES
  final f1 = FocusNode();
  final f2 = FocusNode();
  final f3 = FocusNode();
  final f4 = FocusNode();

  @override
  void dispose() {
    field1.dispose();
    field2.dispose();
    field3.dispose();
    field4.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    timer?.cancel();
    super.dispose();
  }

  int seconds = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mail = context.watch<Createprovider>().mailid;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // OTP BOX SIZE HERE (fixed place)
    final boxW = width * 0.2;
    final boxH = height * 0.1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.1, top: height * 0.02),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
            iconSize: width * 0.04,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.045),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.015),

              // TITLE
              Padding(
                padding: EdgeInsets.only(left: width * 0.07),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Enter the ",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: width * 0.075,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1F4C6B),
                        ),
                      ),
                      TextSpan(
                        text: "code",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: width * 0.075,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F4C6B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.03),

              Padding(
                padding: EdgeInsets.only(left: width * 0.07),
                child: Text(
                  'Enter the 4 digit code that we sent to ',
                  style: TextStyle(
                    fontSize: width * 0.045,
                    color: Color(0xFF53577A),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.07),
                child: Text(
                  mail,
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F4C6B),
                  ),
                ),
              ),

             
              SizedBox(height: height * 0.12),

              // OTP BOXES ROW (fixed)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  otpBox(field1, f1, f2, boxW, boxH),
                  SizedBox(width: width * 0.02),
                  otpBox(field2, f2, f3, boxW, boxH),
                  SizedBox(width: width * 0.02),
                  otpBox(field3, f3, f4, boxW, boxH),
                  SizedBox(width: width * 0.02),
                  otpBox(field4, f4, null, boxW, boxH),
                ],
              ),

              SizedBox(height: height * 0.3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: height * 0.025,
                    color: Color(0xFF1F4C6B),
                  ),
                  SizedBox(width: width * 0.015),
                  Text(
                    "00.$seconds",
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F4C6B),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the OTP?",
                    style: TextStyle(
                      fontSize: width * 0.040,
                      color: Color(0xFF53577A),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        fontSize: width * 0.040,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F4C6B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // OTP BOX WIDGET
  Widget otpBox(
    TextEditingController controller,
    FocusNode currentNode,
    FocusNode? nextNode,
    double width,
    double height,
  ) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F4C6B)),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: currentNode,
          keyboardType: TextInputType.number,
          maxLength: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: width * 0.45,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F4C6B),
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
          ),

          // HERE — UPDATED
          onChanged: (value) {
            if (value.length == 1) {
              if (nextNode != null) {
                FocusScope.of(context).requestFocus(nextNode);
              }

              // Check full OTP
              String userOtp =
                  field1.text + field2.text + field3.text + field4.text;

              if (userOtp.length == 4) {
                if (userOtp == widget.otp) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("OTP Verified Successfully!")),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Incorrect OTP")));

                  // Clear fields on wrong OTP
                  field1.clear();
                  field2.clear();
                  field3.clear();
                  field4.clear();
                  FocusScope.of(context).requestFocus(f1);
                }
              }
            }
          },
        ),
      ),
    );
  }
}
