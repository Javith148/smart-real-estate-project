import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:real_esate_finder/screens/Top agent page/listings.dart';
import 'package:real_esate_finder/screens/Top agent page/sold.dart';
import 'package:share_plus/share_plus.dart';

class Agentprofile extends StatefulWidget {
  final List<Map<String, String>> peopleList;
  final int index;
  const Agentprofile({
    super.key,
    required this.peopleList,
    required this.index,
  });

  @override
  State<Agentprofile> createState() => _AgentprofileState();
}

class _AgentprofileState extends State<Agentprofile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isGridView = true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
Future<void> shareAgentProfile() async {
  final agent = widget.peopleList[widget.index];

  await Share.share(
    '''
🏡 Real Estate Agent Profile

👤 Name: ${agent["name"] ?? agent["title"]}
⭐ Rating: ${agent["rating"]}
🏠 Properties Sold: ${agent["sold"]}

📲 View Agent in App:
https://play.Google/store/app/details/real-esate-finer.customapp}

Trusted agent with proven real estate results.
Download the app and connect instantly.
''',
    subject: 'Agent Profile – ${agent["name"] ?? agent["title"]}',
  );
}



  @override
  Widget build(BuildContext context) {
    final details = widget.peopleList[widget.index];
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final double rating = double.tryParse(details["rating"] ?? "0") ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          DefaultTabController(
            length: 1,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,

                  pinned: false, // fixed illa
                  floating: true, // scroll up panninaa varum
                  snap: true,

                  leading: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: width * 0.05,
                      top: height * 0.02,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: height * 0.02,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  title: Padding(
                    padding: EdgeInsets.only(top: height * 0.025),
                    child: Text(
                      "Profile",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF242B5C),
                      ),
                    ),
                  ),

                  actions: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: width * 0.05,
                        top: height * 0.02,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.ios_share, color: Colors.black),
                        onPressed: () {
                          shareAgentProfile();
                        },
                      ),
                    ),
                  ],
                ),

                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.05),

                      Text(
                        details["name"] ?? "",
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF242B5C),
                          fontSize: width * 0.055,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: height * 0.005),

                      Text(
                        details["mail id"] ?? "",
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF242B5C),
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      // Profile image
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: width * 0.13,
                            backgroundImage: AssetImage(details["image"]!),
                          ),
                          Positioned(
                            bottom: height * 0.008,
                            right: width * 0.01,
                            child: Container(
                              width: width * 0.07,
                              height: height * 0.030,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "#",
                                      style: GoogleFonts.montserrat(
                                        fontSize: width * 0.02,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${widget.index + 1}",
                                      style: GoogleFonts.montserrat(
                                        fontSize: width * 0.03,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.04),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height * 0.085,
                            width: width * 0.25,
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.008,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(30, 68, 137, 255),
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rating.toString(),
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF242B5C),
                                    fontSize: width * 0.045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(height: height * 0.006),

                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final double starSize =
                                        constraints.maxWidth * 0.13;

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(5, (index) {
                                        if (index < rating.floor()) {
                                          return Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: starSize,
                                          );
                                        } else if (index < rating) {
                                          return Icon(
                                            Icons.star_half,
                                            color: Colors.amber,
                                            size: starSize,
                                          );
                                        } else {
                                          return Icon(
                                            Icons.star_border,
                                            color: Colors.amber,
                                            size: starSize,
                                          );
                                        }
                                      }),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: width * 0.04),

                          Container(
                            height: height * 0.085,
                            width: width * 0.25,
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.008,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(30, 68, 137, 255),
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  details["reviews"] ?? "",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF242B5C),
                                    fontSize: width * 0.045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: width * 0.008),
                                Text(
                                  "reviews",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF242B5C),
                                    fontSize: width * 0.030,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: width * 0.04),
                          Container(
                            height: height * 0.085,
                            width: width * 0.25,
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.008,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(30, 68, 137, 255),
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  details["sold"] ?? "",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF242B5C),
                                    fontSize: width * 0.045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: width * 0.008),
                                Text(
                                  "sold",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF242B5C),
                                    fontSize: width * 0.030,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),

                      // TabBar (separate)
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
                          dividerColor: const Color.fromRGBO(0, 0, 0, 0),
                          labelColor: const Color(0xFF242B5C),
                          unselectedLabelColor: const Color(0xFFA1A4C1),
                          labelStyle: TextStyle(
                            fontSize: width * 0.030,
                            fontWeight: FontWeight.w700,
                          ),
                          tabs: const [
                            Tab(text: "Listings"),
                            Tab(text: "Sold"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                controller: tabController,
                children: [Listings(), Sold()],
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: height * 0.16,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white, // 100% white
                    Colors.white, // stronger white
                    Colors.white.withOpacity(0.4), // mid fade
                    Colors.white.withOpacity(0), // fully transparent
                  ],
                  stops: const [0.0, 0.3, 0.6, 1.0],
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8BC83F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: width * 0.59,
                    height: height * 0.07,
                    child: Center(
                      child: Text(
                        "Start Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
