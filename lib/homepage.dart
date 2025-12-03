import 'package:flutter/material.dart';
import 'package:real_esate_finder/loader.dart';
import 'package:real_esate_finder/main_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,

      // BODY SWITCHES CORRECTLY
      body: pages[pageIndex],

      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 6),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 3),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: pageIndex,
          selectedItemColor: const Color(0xFF1F4C6B),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,

          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },

          items: [
            _navItem(
              isSelected: pageIndex == 0,
              selectedIcon: Icons.home,
              unselectedIcon: Icons.home_outlined,
            ),
            _navItem(
              isSelected: pageIndex == 1,
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
    );
  }

  BottomNavigationBarItem _navItem({
    required bool isSelected,
    required IconData selectedIcon,
    required IconData unselectedIcon,
  }) {
    return BottomNavigationBarItem(
      label: "",
      icon: Column(
        children: [
          Icon(
            isSelected ? selectedIcon : unselectedIcon,
            size: 28,
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              width: 22,
              height: 2,
              decoration: BoxDecoration(
                color: const Color(0xFF1F4C6B),
                borderRadius: BorderRadius.circular(2),
              ),
            )
          else
            const SizedBox(height: 3),
        ],
      ),
    );
  }
}

// SEPARATE HOME BODY (YOUR ORIGINAL UI)
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.30,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: width * -0.25,
                  top: height * -0.15,
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
                              color: const Color(0xFF1F4C6B),
                            ),
                            SizedBox(width: width * 0.02),
                            Text(
                              "Coimbatore, TN",
                              style: TextStyle(
                                fontSize: width * 0.032,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1F4C6B),
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
                            color: const Color(0xFF8BC83F),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.notifications_none_outlined,
                          size: height * 0.025,
                          color: const Color(0xFF1F4C6B),
                        ),
                      ),

                      SizedBox(width: width * 0.04),

                      Container(
                        width: width * 0.12,
                        height: width * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 0.1),
                        ),
                        child: Icon(
                          Icons.person_2_outlined,
                          size: height * 0.025,
                          color: const Color(0xFF1F4C6B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
