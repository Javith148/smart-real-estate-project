import 'package:flutter/material.dart';
import 'package:real_esate_finder/screens/Termspage.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController input = TextEditingController();

  int openBuyerIndex = -1;
  int openAgentIndex = -1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    input.addListener(() {
      searchQuestion(input.text.trim());
    });
  }

  // ---------------- BUYER QUESTIONS ----------------
  List<Map<String, String>> buyerFaq = [
    {
      "q": "What documents are needed to buy a home?",
      "a":
          "You need ID proof, address proof, income proof, and recent bank statements.",
    },
    {
      "q": "How do I compare two properties easily?",
      "a":
          "Use filters like price, location, amenities, and age to compare listings.",
    },
    {
      "q": "Can I schedule a property visit?",
      "a":
          "Yes, you can request a visit and the seller will confirm the timing.",
    },
    {
      "q": "Are photos on listings original?",
      "a":
          "All uploaded images are reviewed and approved to ensure authenticity.",
    },
    {
      "q": "Do you offer EMI options?",
      "a": "Many properties include loan assistance and flexible EMI plans.",
    },
    {
      "q": "Where can I check property legal status?",
      "a":
          "Each listing includes available legal verification shared by the seller.",
    },
    {
      "q": "When will I receive owner contact details?",
      "a": "Owner contact details are shown instantly on the property page.",
    },
    {
      "q": "Why should I use Rise Real Estate?",
      "a":
          "It provides verified listings, direct contact, and smart search tools.",
    },
    {
      "q": "Is negotiation allowed?",
      "a": "Yes, you can negotiate price directly with the owner or agent.",
    },
    {
      "q": "Does the app support rental properties?",
      "a": "Yes, rental houses, apartments, and PG options are available.",
    },
  ];

  // ---------------- AGENT QUESTIONS ----------------
  List<Map<String, String>> agentFaq = [
    {
      "q": "How can I increase my property visibility?",
      "a": "Use premium boosting to appear at the top and reach more buyers.",
    },
    {
      "q": "Can buyers contact me directly?",
      "a": "Yes, buyers can reach you via call, WhatsApp, or in-app chat.",
    },
    {
      "q": "What are the requirements for listing approval?",
      "a":
          "Upload clear photos, valid documents, and complete property details.",
    },
    {
      "q": "Do I need to renew my listing?",
      "a": "Listings auto-renew monthly, and you can refresh them manually.",
    },
    {
      "q": "Are premium plans refundable?",
      "a": "No, once activated, premium plans are non-refundable.",
    },
    {
      "q": "Where can I track my leads?",
      "a": "All buyer inquiries appear in the Leads section of your dashboard.",
    },
    {
      "q": "When can I edit my listing?",
      "a": "You can update photos, price, and description anytime.",
    },
    {
      "q": "Why was my listing rejected?",
      "a": "It may be rejected due to unclear photos or incorrect details.",
    },
    {
      "q": "Is bulk property upload available?",
      "a":
          "Yes, multiple properties can be uploaded using the bulk upload tool.",
    },
    {
      "q": "Does Rise Real Estate charge commission?",
      "a":
          "No commission is charged; only paid boosting options are available.",
    },
  ];

  void searchQuestion(String text) {
    if (text.isEmpty) {
      setState(() {
        openBuyerIndex = -1;
        openAgentIndex = -1;
      });
      return;
    }

    String query = text.toLowerCase();

    int buyerMatchIndex = buyerFaq.indexWhere(
      (item) => item["q"]!.toLowerCase().contains(query),
    );

    int agentMatchIndex = agentFaq.indexWhere(
      (item) => item["q"]!.toLowerCase().contains(query),
    );

    if (buyerMatchIndex != -1) {
      Map<String, String> matched = buyerFaq[buyerMatchIndex];
      buyerFaq.removeAt(buyerMatchIndex);
      buyerFaq.insert(0, matched);

      setState(() {
        tabController.index = 0;
        openBuyerIndex = 0;
        openAgentIndex = -1;
      });
      return;
    }

    if (agentMatchIndex != -1) {
      Map<String, String> matched = agentFaq[agentMatchIndex];
      agentFaq.removeAt(agentMatchIndex);
      agentFaq.insert(0, matched);

      setState(() {
        tabController.index = 1;
        openAgentIndex = 0;
        openBuyerIndex = -1;
      });
      return;
    }

    setState(() {
      openBuyerIndex = -1;
      openAgentIndex = -1;
    });
  }

  void launchWebsite() async {
    const url = 'https://www.google.com';
    final uri = Uri.parse(url);

    try {
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

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
          padding: EdgeInsets.only(left: width * 0.07),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
            iconSize: width * 0.04,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.08,
            top: height * 0.055,
            right: width * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "FAQ ",
                      style: TextStyle(
                        fontSize: width * 0.080,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1F4C6B),
                      ),
                    ),
                    TextSpan(
                      text: '& ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.080,
                        fontFamily: 'Lato',
                      ),
                    ),
                    TextSpan(
                      text: "Support ",
                      style: TextStyle(
                        fontSize: width * 0.080,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1F4C6B),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),

              Text(
                'Find answer to your problem using this app.',
                style: TextStyle(
                  fontSize: width * 0.040,
                  color: const Color(0xFF53577A),
                ),
              ),
              SizedBox(height: height * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Visit website
                  GestureDetector(
                    onTap: launchWebsite,
                    child: Row(
                      children: [
                        _iconBox(icon: Icons.language, width: width * 0.75),
                        SizedBox(width: width * 0.04),
                        Text(
                          "Visit our website",
                          style: TextStyle(
                            fontSize: width * 0.040,
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
                        _iconBox(icon: Icons.mail, width: width * 0.75),
                        SizedBox(width: width * 0.04),
                        Text(
                          "Email us",
                          style: TextStyle(
                            fontSize: width * 0.040,
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
                        _iconBox(icon: Icons.description, width: width * 0.75),
                        SizedBox(width: width * 0.04),
                        Text(
                          "Terms of Service",
                          style: TextStyle(
                            fontSize: width * 0.040,
                            color: const Color(0xFF242B5C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.06),

              // ---------------- SEARCH BOX ----------------
              Container(
                width: width * 0.85,
                height: width * 0.15,
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F4F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: width * 0.05,
                      color: const Color(0xFFA1A4C1),
                    ),
                    SizedBox(width: width * 0.05),

                    Expanded(
                      child: TextField(
                        controller: input,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Try find “how to”",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.04),

              // ---------------- TABS ----------------
              Column(
                children: [
                  Container(
                    width: width * 0.85,
                    height: width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      controller: tabController,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelColor: const Color(0xFF242B5C),
                      unselectedLabelColor: const Color(0xFFA1A4C1),
                      tabs: const [
                        Tab(text: "Buyer"),
                        Tab(text: "Estate Agent"),
                      ],
                    ),
                  ),
                Padding(padding: EdgeInsets.symmetric(vertical: height * 0.03),child: 
                  SizedBox(
                    height: height * 0.65,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // ---------------- BUYER TAB ----------------
                        ListView.builder(
                          itemCount: buyerFaq.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    buyerFaq[index]["q"]!,
                                    style: TextStyle(fontSize: width * 0.055 ,color: const Color(0xFF242B5C)),
                                  ),
                                  trailing: Icon(
                                    openBuyerIndex == index
                                        ? Icons.remove
                                        : Icons.add,
                                    color: Colors.green,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      openBuyerIndex = openBuyerIndex == index
                                          ? -1
                                          : index;
                                    });
                                  },
                                ),

                                if (openBuyerIndex == index)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.07,
                                    ),
                                    child: Text(
                                      buyerFaq[index]["a"]!,
                                      style: TextStyle(
                                        fontSize: width * 0.045,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),

                        // ---------------- AGENT TAB ----------------
                        ListView.builder(
                          itemCount: agentFaq.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    agentFaq[index]["q"]!,
                                    style: TextStyle(fontSize: width * 0.055),
                                  ),
                                  trailing: Icon(
                                    openAgentIndex == index
                                        ? Icons.remove
                                        : Icons.add,
                                    color: Colors.green,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      openAgentIndex = openAgentIndex == index
                                          ? -1
                                          : index;
                                    });
                                  },
                                ),

                                if (openAgentIndex == index)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.07,
                                    ),
                                    child: Text(
                                      agentFaq[index]["a"]!,
                                      style: TextStyle(
                                        fontSize: width * 0.045,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
               ) ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
