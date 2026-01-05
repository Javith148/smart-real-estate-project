import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_esate_finder/screens/Top%20agent%20page/agentprofile.dart';

class TopAgent extends StatelessWidget {
  final List<Map<String, String>> peopleList;

  const TopAgent({super.key, required this.peopleList});

  @override
  Widget build(BuildContext context) {

  
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: height * 0.09,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.09, top: height * 0.03),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),

              Text(
                "Top Estate Agent",
                style: TextStyle(
                  color: const Color(0xFF242B5C),
                  fontSize: width * 0.080,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: height * 0.01),

              Text(
                "Find the best recommendations place to live",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: height * 0.04),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: peopleList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: (width * 0.45) / (height * 0.29),
                ),
                itemBuilder: (context, index) {
                  final item = peopleList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Agentprofile(
                            peopleList: peopleList,
                            index: index,
                          ),
                        ),
                      );
                    },

                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(186, 244, 242, 242),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.directional(
                                start: width * 0.025,
                                top: height * 0.015,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
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
                                            text: "${index + 1}",
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
                                ],
                              ),
                            ),

                            CircleAvatar(
                              radius: width * 0.15,
                              backgroundImage: AssetImage(item["image"]!),
                            ),
                            SizedBox(height: height * 0.01),

                            Center(
                              child: Expanded(
                                child: Text(
                                  item["name"] ?? "",
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFF242B5C),
                                    fontSize: width * 0.042,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: height * 0.015,
                                ),
                                Text(
                                  item["rating"] ?? "",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF242B5C),
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: width * 0.02),
                                Icon(Icons.home, size: height * 0.015),
                                Text(
                                  item["sold"] ?? "",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF242B5C),
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
