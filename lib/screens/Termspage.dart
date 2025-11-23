import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {

    // 📌 Responsive font sizes
    final width = MediaQuery.of(context).size.width;

    double getFontSize() {
      if (width < 360) {
        return 13; // Small phone
      } else if (width < 480) {
        return 15; // Medium phone
      } else {
        return 17; // Large phone
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms of Service",
          style: TextStyle(fontSize: getFontSize() + 3),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          """
Terms and Services – Real Estate Finder App
Last Updated: 18 November 2025

1. Acceptance of Terms
By using the Real Estate Finder app, you agree to these Terms and Services. If you do not agree, please stop using the app.

2. Services We Provide
• Property search for rent, sale, and lease  
• Viewing property details like price, photos, and location  
• Contact options for buyers, sellers, and agents  
• Map-based location viewing  

3. User Responsibilities
• You must provide correct information when creating an account  
• Do not upload fake, misleading, or inappropriate content  
• Do not use the app for fraud or illegal activities  

4. Listing Rules
If you add a property:  
• Information must be true and verified  
• No fake photos or price details  
• You are responsible for the accuracy of your listing  

5. Privacy & Data Usage
We collect basic information such as:  
• Name, email, mobile number  
• Location (for nearby properties)  
• Uploaded property details  

Your data is stored securely and will not be sold to third parties.

6. Third-Party Services
We may use Google Maps or external links. We are not responsible for their content or service.

7. No Guarantee or Warranty
• We do not guarantee property availability  
• We do not verify all user-uploaded listings  
• Property deals happen between buyer & seller — we are not responsible  

8. Limitation of Liability
We are not responsible for:  
• Misleading information posted by users  
• Loss, fraud, or damage caused by buyers/sellers  
• App downtime, technical errors, or data loss  

9. Account Termination
We may suspend or delete accounts that:  
• Violate these terms  
• Upload fake or illegal content  
• Use the app abusively  

10. Changes to Terms
We may update these terms anytime. Continued use of the app means you accept the updated terms.

11. Contact Us
For help or support:  
Email: support@realestatefinder.com  
Phone: +91-XXXXXXXXXX
          """,
          style: TextStyle(
            fontSize: getFontSize(),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
