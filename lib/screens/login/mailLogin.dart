import 'package:flutter/material.dart';
import 'package:real_esate_finder/screens/register/register.dart';

class Maillogin extends StatefulWidget {
  const Maillogin({super.key});

  @override
  State<Maillogin> createState() => _MailloginState();
}

class _MailloginState extends State<Maillogin> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  bool isFocused = false;
  FocusNode passFocus = FocusNode();
  bool isPassFocused = false;

  String? emailError;
  String? passError;

  @override
  void initState() {
    super.initState();

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
  }

  Widget buildCombinedError(double width) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // If no error → empty space
    if (emailError == null && passError == null) {
      return const SizedBox.shrink();
    }

    // If both fields have error → show only ONE message
    String finalMessage;

    if (emailError != null && passError != null) {
      finalMessage = "Please enter valid email & password";
    } else if (emailError != null) {
      finalMessage = emailError!;
    } else {
      finalMessage = passError!;
    }

    return Container(
      width: width * 0.85,
      height: height * 0.07,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1F4C6B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Expanded(
          child: Text(
            finalMessage,
            style: TextStyle(color: Colors.white, fontSize: width * 0.035),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.015),
              Image.asset("assets/login_back.png"),
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
                            text: "Let's",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: width * 0.070,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF1F4C6B),
                            ),
                          ),
                          TextSpan(
                            text: "\tSign In",
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

              SizedBox(height: height * 0.03),

              Padding(
                padding: EdgeInsets.only(left: width * 0.07),
                child: Row(
                  children: [
                    Text(
                      'Welcome back! Please sign in to continue..',
                      style: TextStyle(
                        fontSize: width * 0.040,
                        color: const Color(0xFF53577A),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.05),
              buildCombinedError(width),
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
                       
                      },
                      child: Text(
                        "Forget password?",
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

              // LOGIN BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8BC83F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // run validators; they set emailError/passError inside
                  final valid = _formKey.currentState!.validate();

                  // if invalid, the combined container will show messages (setState already called inside validators)
                  if (valid) {
                    // clear errors on success
                    setState(() {
                      emailError = null;
                      passError = null;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Form Submitted")),
                    );

                    print(
                      "mail id ${mailController.text}\npassword ${passController.text}",
                    );

                    mailController.clear();
                    passController.clear();
                  } else {
                    // ensure rebuild to show messages (validators already called but call setState once)
                    setState(() {});
                  }
                },
                child: SizedBox(
                  width: width * 0.59,
                  height: height * 0.07,
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.045),

              // OR LINE
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
                        alignment: Alignment.center,
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // SOCIAL BUTTONS
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.09,
                  vertical: height * 0.035,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.38,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 239, 240),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/google_icon.png",
                          width: width * 0.08,
                        ),
                      ),
                    ),
                    Container(
                      width: width * 0.38,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 239, 240),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/facebook.png",
                          width: width * 0.08,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.040),

              // REGISTER
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
        ),
      ),
    );
  }
}
