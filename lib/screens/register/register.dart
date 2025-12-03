import 'dart:math';

import 'package:flutter/material.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:real_esate_finder/homepage.dart';
import 'package:real_esate_finder/screens/FAQpage/FAQPage.dart';
import 'package:real_esate_finder/screens/register/Otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode nameFocus = FocusNode();

  bool isFocused = false;
  bool isPassFocused = false;
  bool isNameFocused = false;

  String? emailError;
  String? passError;
  String? nameError;

  String storeName = "";
  String storePass = "";
  String storeMail = "";

  void getdata() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      storeName = pref.getString("name") ?? "";
      storePass = pref.getString("pass") ?? "";
      storeMail = pref.getString("mail") ?? "";
    });
  }

  void savedata() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setString("name", nameController.text);
    await pref.setString("mail", mailController.text);
    await pref.setString("pass", passController.text);

    setState(() {
      storeName = nameController.text;
      storeMail = mailController.text;
      storePass = passController.text;
    });

    nameController.clear();
    mailController.clear();
    passController.clear();
  }

  @override
  void initState() {
    super.initState();
    getdata();

    emailFocus.addListener(() {
      setState(() {
        isFocused = emailFocus.hasFocus;
      });
    });

    passFocus.addListener(() {
      setState(() {
        isPassFocused = passFocus.hasFocus;
      });
    });

    nameFocus.addListener(() {
      setState(() {
        isNameFocused = nameFocus.hasFocus;
      });
    });
  }

  String otpGenrated() {
    return (1000 + Random().nextInt(9000)).toString();
  }

  Future<void> sendOtpMail(String toMail, String otp) async {
    String username = 'javithjavi148@gmail.com';
    String password = 'mkhf uefe xbff udta';

    final smtpServer = gmail(username, password);

    final message = Message()
     ..from = Address(username, "Smart Real esate")
..recipients.add(toMail)
..subject = "🔐 Verification Code – Your One-Time Password (OTP)"
..html = """
<!DOCTYPE html>
<html>
<body style="font-family: Arial, sans-serif; background-color:#f4f4f4; padding:20px;">
  <div style="max-width:500px; margin:auto; background:white; padding:25px; border-radius:10px; box-shadow:0 2px 8px rgba(0,0,0,0.1);">

    <h2 style="color:#333; text-align:center;">Your Verification Code</h2>
    <p style="font-size:15px; color:#555;">
      Hello,
      <br><br>
      Please use the One-Time Password (OTP) provided below to verify your email address.
    </p>

    <div style="text-align:center; margin:30px 0;">
      <span style="font-size:32px; font-weight:bold; padding:12px 30px; background:#eef1ff; color:#2b3aff; border-radius:8px; display:inline-block;">
        $otp
      </span>
    </div>

    <p style="font-size:14px; color:#555;">
      This OTP is valid for <b>5 minutes</b>. Do not share it with anyone for security reasons.
    </p>

    <hr style="border:0; border-top:1px solid #eee; margin:20px 0;">

    <p style="font-size:13px; color:#888; text-align:center;">
      If you didn’t request this, please ignore this email.
      <br><br>
      — My App Security Team
    </p>

  </div>
</body>
</html>
""";


    try {
      await send(message, smtpServer);
      print("Mail Sent Successfully");
    } catch (e) {
      print("Mail Error: $e");
    }
  }

  Widget buildCombinedError(double width) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // If no error → hide the box
    if (emailError == null && passError == null && nameError == null) {
      return const SizedBox.shrink();
    }

    // Show only ONE message (priority: name → email → password)
    String finalMessage;

    if (nameError != null && emailError != null && passError != null) {
      finalMessage = "Please enter valid name, email & password";
    } else if (nameError != null && emailError != null) {
      finalMessage = "Please enter valid name & email";
    } else if (nameError != null && passError != null) {
      finalMessage = "Please enter valid name & password";
    } else if (emailError != null && passError != null) {
      finalMessage = "Please enter valid email & password";
    } else if (nameError != null) {
      finalMessage = nameError!;
    } else if (emailError != null) {
      finalMessage = emailError!;
    } else {
      finalMessage = passError!;
    }

    return Container(
      width: screenWidth * 0.85,
      height: screenHeight * 0.07,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1F4C6B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          finalMessage,
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.035),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.045),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.015),

                // TITLE
                Padding(
                  padding: EdgeInsets.only(left: width * 0.07),
                  child: Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Create your ",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: width * 0.075,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF1F4C6B),
                              ),
                            ),
                            TextSpan(
                              text: "account",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: width * 0.075,
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

                SizedBox(height: height * 0.03),

                Padding(
                  padding: EdgeInsets.only(left: width * 0.07),
                  child: Row(
                    children: [
                      Text(
                        'Your journey begins with a new account.',
                        style: TextStyle(
                          fontSize: width * 0.045,
                          color: const Color(0xFF53577A),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.05),
                buildCombinedError(width),
                SizedBox(height: height * 0.02),
                // NAME FIELD
                Container(
                  width: width * 0.85,
                  height: width * 0.15,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isNameFocused
                          ? const Color(0xFF4CAF50)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      // LEFT ICON when not focused
                      if (!isNameFocused)
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.04),
                          child: Icon(
                            Icons.person_outline,
                            size: width * 0.06,
                            color: const Color(0xFF1F4C6B),
                          ),
                        ),

                      // TEXTFIELD
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: isNameFocused ? width * 0.04 : width * 0.03,
                            right: width * 0.03,
                          ),
                          child: TextFormField(
                            controller: nameController,
                            focusNode: nameFocus,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Full Name",
                            ),
                            onChanged: (value) {
                              context.read<Createprovider>().setUsername(
                                nameController.text.trim(),
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  nameError = "Please enter your name";
                                });
                                return "";
                              }
                              if (value.length < 3) {
                                setState(() {
                                  nameError =
                                      "Name must be at least 3 characters";
                                });
                                return "";
                              }

                              setState(() {
                                nameError = null;
                              });
                              return null;
                            },
                          ),
                        ),
                      ),

                      // RIGHT ICON when focused
                      if (isNameFocused)
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.04),
                          child: Icon(
                            Icons.person_outline,
                            size: width * 0.06,
                            color: const Color(0xFF1F4C6B),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                // EMAIL FIELD
                Container(
                  width: width * 0.85,
                  height: width * 0.15,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isFocused
                          ? const Color(0xFF4CAF50)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (!isFocused)
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.04),
                          child: Icon(
                            Icons.email_outlined,
                            size: width * 0.06,
                            color: const Color(0xFF1F4C6B),
                          ),
                        ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: isFocused ? width * 0.04 : width * 0.03,
                            right: width * 0.03,
                          ),
                          child: TextFormField(
                            controller: mailController,
                            focusNode: emailFocus,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                            ),
                            onChanged: (value) {
                              context.read<Createprovider>().setMailid(
                                mailController.text.trim(),
                              );
                            },
                            // validator only sets emailError and returns a non-null string to mark invalid
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  emailError = "Please enter your email";
                                });
                                return "";
                              }
                              if (!value.contains("@")) {
                                setState(() {
                                  emailError = "Please enter a valid email";
                                });
                                return "";
                              }

                              // valid -> clear error
                              setState(() {
                                emailError = null;
                              });
                              return null;
                            },
                          ),
                        ),
                      ),

                      if (isFocused)
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.04),
                          child: Icon(
                            Icons.email_outlined,
                            size: width * 0.06,
                            color: const Color(0xFF1F4C6B),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),

                // PASSWORD FIELD
                Container(
                  width: width * 0.85,
                  height: width * 0.15,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isPassFocused
                          ? const Color(0xFF4CAF50)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (!isPassFocused)
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.04),
                          child: Icon(
                            Icons.lock_outline,
                            size: width * 0.06,
                            color: const Color(0xFF1F4C6B),
                          ),
                        ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: isPassFocused ? width * 0.04 : width * 0.03,
                            right: width * 0.03,
                          ),
                          child: TextFormField(
                            controller: passController,
                            focusNode: passFocus,
                            obscureText: _obscurePassword,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                            ),
                            onChanged: (value) {
                              context.read<Createprovider>().setPassword(
                                passController.text.trim(),
                              );
                            },

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  passError = "Please enter your password";
                                });
                                return "";
                              }
                              if (value.length < 6) {
                                setState(() {
                                  passError =
                                      "Password must be at least 6 characters";
                                });
                                return "";
                              }

                              setState(() {
                                passError = null;
                              });
                              return null;
                            },
                          ),
                        ),
                      ),

                      if (isPassFocused)
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.04),
                          child: Icon(
                            Icons.lock_outline,
                            size: width * 0.06,
                            color: const Color(0xFF1F4C6B),
                          ),
                        ),
                    ],
                  ),
                ),

                // rest of UI...
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.09),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FAQPage()),
                          );
                        },
                        child: Text(
                          "Terms of service",
                          style: TextStyle(
                            color: const Color(0xFF1F4C6B),
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Text(
                          _obscurePassword ? "Show password" : "Hide password",
                          style: TextStyle(
                            color: const Color(0xFF1F4C6B),
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.025),

                // Resgiter BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8BC83F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      savedata();

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("username", storeName);
                      await prefs.setBool("isLoggedIn", true);

                      String userMail = mailController.text.trim();

                      String otp = otpGenrated();

                      await sendOtpMail(userMail, otp);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpPage(otp: otp),
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: width * 0.59,
                    height: height * 0.07,
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                Text(
                  "name ${storeName}\n mail id ${storeMail}\n pass ${storePass} ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
