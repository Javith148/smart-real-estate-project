import 'package:flutter/material.dart';
import 'package:real_esate_finder/screens/Termspage.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQpage extends StatefulWidget {
  const FAQpage({super.key});

  @override
  State<FAQpage> createState() => _FAQpageState();
}

class _FAQpageState extends State<FAQpage> {
  // Visit website
  void launchWebsite() async {
    const url = 'https://www.google.com';
    final uri = Uri.parse(url);

    try {
      bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!launched) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    }
  }

  // Email
  void launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@example.com',
    );
    await launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.03, top: height * 0.003),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Text(
              "FAQ & Support",
              style: TextStyle(
                fontSize: width * 0.085,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F4C6B),
              ),
            ),

            SizedBox(height: height * 0.01),

            Text(
              'Find answer to your problem using this app.',
              style: TextStyle(
                fontSize: width * 0.042,
                color: const Color(0xFF53577A),
              ),
            ),

            SizedBox(height: height * 0.04),

            /// OPTIONS LIST
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Visit website
                GestureDetector(
                  onTap: launchWebsite,
                  child: Row(
                    children: [
                      _iconBox(icon: Icons.language, width: width),
                      SizedBox(width: width * 0.04),
                      Text(
                        "Visit our website",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          color: const Color(0xFF242B5C),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.03),

                /// Email us
                GestureDetector(
                  onTap: launchEmail,
                  child: Row(
                    children: [
                      _iconBox(icon: Icons.mail, width: width),
                      SizedBox(width: width * 0.04),
                      Text(
                        "Email us",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          color: const Color(0xFF242B5C),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.03),

                /// Terms of Service
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TermsPage()),
                    );
                  },
                  child: Row(
                    children: [
                      _iconBox(icon: Icons.description, width: width),
                      SizedBox(width: width * 0.04),
                      Text(
                        "Terms of Service",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          color: const Color(0xFF242B5C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.05),

            /// SEARCH BOX
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              height: height * 0.065,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F4F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Try find “how to”',
                  hintStyle: TextStyle(
                    fontSize: width * 0.04,
                    color: const Color(0xFFA1A4C1),
                  ),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFA1A4C1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Circle Icon Widget (Responsive)
  Widget _iconBox({required IconData icon, required double width}) {
    return Container(
      width: width * 0.12,
      height: width * 0.12,
      decoration: BoxDecoration(
        color: const Color(0xFF1F4C6B),
        borderRadius: BorderRadius.circular(width * 0.06),
      ),
      child: Icon(icon, color: Colors.white, size: width * 0.055),
    );
  }
}
