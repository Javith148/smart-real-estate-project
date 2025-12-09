import 'package:flutter/material.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:real_esate_finder/loader.dart';
import 'package:real_esate_finder/main_login.dart';
import 'package:real_esate_finder/screens/Homepage_tab/alltab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// SEARCH PAGE
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: const Color(0xFF1F4C6B),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logout(context);
            },
          ),
        ],
      ),

      body: const Center(
        child: Text("Search Screen", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

// MAIN PAGE
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final List<Widget> pages = [
    HomeBody(),
    Loader(),
    Center(child: Text("Favorites Page")),
    Center(child: Text("Profile Page")),
  ];

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[pageIndex],

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 2,
            currentIndex: pageIndex,

            selectedItemColor: const Color(0xFF1F4C6B),
            unselectedItemColor: Colors.grey,

            showSelectedLabels: false,
            showUnselectedLabels: false,

            onTap: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              } else {
                setState(() {
                  pageIndex = value;
                });
              }
            },

            items: [
              _navItem(
                isSelected: pageIndex == 0,
                selectedIcon: Icons.home,
                unselectedIcon: Icons.home_outlined,
              ),
              _navItem(
                isSelected: false,
                selectedIcon: Icons.search,
                unselectedIcon: Icons.search_outlined,
              ),
              _navItem(
                isSelected: pageIndex == 2,
                selectedIcon: Icons.favorite,
                unselectedIcon: Icons.favorite_border,
              ),
              _navItem(
                isSelected: pageIndex == 3,
                selectedIcon: Icons.person,
                unselectedIcon: Icons.person_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem({
    required bool isSelected,
    required IconData selectedIcon,
    required IconData unselectedIcon,
  }) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BottomNavigationBarItem(
      label: "",
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? selectedIcon : unselectedIcon,
            size: height * 0.028,
          ),
          SizedBox(height: height * 0.003),

          if (isSelected)
            Container(
              width: width * 0.015,
              height: width * 0.015,
              decoration: const BoxDecoration(
                color: Color(0xFF1F4C6B),
                shape: BoxShape.circle,
              ),
            )
          else
            SizedBox(height: width * 0.02),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final username = context.watch<Createprovider>().username;

    return DefaultTabController(
      length: 4,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.33,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: width * -0.25,
                    top: height * -0.18,
                    child: Container(
                      width: width * 0.95,
                      height: height * 0.55,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(83, 102, 181, 230),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Positioned(
                    top: height * 0.05,
                    left: width * 0.07,
                    right: width * 0.05,
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.35,
                          height: width * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: width * 0.035),
                              Icon(
                                Icons.location_on,
                                size: height * 0.022,
                                color: Color(0xFF1F4C6B),
                              ),
                              SizedBox(width: width * 0.02),
                              Text(
                                "Coimbatore, TN",
                                style: TextStyle(
                                  fontSize: width * 0.032,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F4C6B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.23),

                        Container(
                          width: width * 0.12,
                          height: width * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF8BC83F),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.notifications_none_outlined,
                            size: height * 0.025,
                            color: Color(0xFF1F4C6B),
                          ),
                        ),
                        SizedBox(width: width * 0.04),

                        Container(
                          width: width * 0.12,
                          height: width * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 0.2),
                          ),
                          child: Icon(
                            Icons.person_2_outlined,
                            size: height * 0.025,
                            color: Color(0xFF1F4C6B),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: height * 0.15,
                    left: width * 0.07,
                    right: width * 0.05,
                    child: Text(
                      "Hey, $username!\nLet's start exploring",
                      style: TextStyle(
                        color: Color(0xFF242B5C),
                        fontSize: width * 0.080,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Positioned(
                    top: height * 0.27,
                    left: width * 0.065,
                    right: width * 0.065,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(
                          Icons.mic_none_outlined,
                          color: Colors.grey,
                        ),
                        labelText: "Search Home, Apartment, etc",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TABBAR – NOT STICKY NOW
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color(0xFF234F68),
                  borderRadius: BorderRadius.circular(20),
                ),

                indicatorPadding: EdgeInsets.symmetric(
                  vertical: height * 0.002,
                  horizontal: width * 0.03,
                ),

                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 0,
                dividerColor: Colors.transparent,

                labelPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: height * 0.009,
                ),

                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF242B5C),

                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "House"),
                  Tab(text: "Apartment"),
                  Tab(text: "Villa"),
                ],
              ),
            ),
          ),
        ],

        body: TabBarView(
          children: [
            Alltab(),
            Center(child: Text("Homes List")),
            Center(child: Text("Apartments List")),
            Center(child: Text("Villas List")),
          ],
        ),
      ),
    );
  }
}
