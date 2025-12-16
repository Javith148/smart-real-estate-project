import 'package:flutter/material.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:real_esate_finder/cartpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_esate_finder/loader.dart';
import 'package:real_esate_finder/main_login.dart';
import 'package:real_esate_finder/screens/Homepage_tab/alltab.dart';
import 'package:real_esate_finder/userprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
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
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
                return;
              }

              // FAVORITE PAGE (index = 2)
              if (value == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cartpage()),
                );
                return;
              }

              // USER PAGE (index = 3)
              if (value == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Userprofile()),
                );
                return;
              }

              // HOME (index = 0)
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

class HomeBody extends StatefulWidget {
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  // 🔹 STATE (LOGIC ONLY)
  List<String> locations = ["Five corner,townhall,coimatore,\ntamilNadu"];

  int selectedIndex = 0;

  Future<void> saveLocationsToPrefs(List<String> locations) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_locations', locations);
  }

  Future<List<String>> loadLocationsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('saved_locations') ?? [];
  }

  @override
  void initState() {
    super.initState();
    loadSavedLocations();
  }

  Future<void> loadSavedLocations() async {
    final saved = await loadLocationsFromPrefs();
    if (saved.isNotEmpty) {
      setState(() {
        locations = saved;
        selectedIndex = 0;
      });
    }
  }

  String getSelectedLocationTitle() {
    if (locations.isEmpty) return "";

    String address = locations[selectedIndex].trim();

    if (address.contains(',')) {
      return address.split(',').first.trim();
    }

    return address.split(' ').first.trim();
  }

  void _showDeleteDialog(
    BuildContext context,
    int index,
    StateSetter setModalState,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔴 ICON
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF234F68).withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFF234F68),
                    size: 34,
                  ),
                ),

                const SizedBox(height: 16),

                // 🔹 TITLE
                const Text(
                  "Delete Address",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F4C6B),
                  ),
                ),

                const SizedBox(height: 10),

                // 🔹 MESSAGE
                const Text(
                  "Are you sure you want to delete this address?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                const SizedBox(height: 24),

                // 🔹 ACTION BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1F4C6B)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Color(0xFF1F4C6B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF234F68),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            locations.removeAt(index);
                            selectedIndex = locations.isNotEmpty ? 0 : -1;
                          });

                          await saveLocationsToPrefs(locations);

                          setModalState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //🔹 LOCATION BOTTOM SHEET
  void openLocationBottomDrawer(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.all(width * 0.08),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: width * 0.1,
                    height: height * 0.005,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Location",
                        style: TextStyle(
                          fontSize: width * 0.052,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F4C6B),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.20,
                        height: height * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1F4C6B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            openAddAddressSheet(context, (newAddress) async {
                              setState(() {
                                locations.add(newAddress);
                                selectedIndex = locations.length - 1;
                              });

                              await saveLocationsToPrefs(locations);

                              setModalState(() {});
                            });
                          },

                          child: Text(
                            "Edit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.04),

                  // 🔹 LOCATION LIST (DESIGN SAME)
                  Column(
                    children: List.generate(locations.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: height * 0.03),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            setModalState(() {});
                          },
                          onLongPress: () {
                            _showDeleteDialog(context, index, setModalState);
                          },
                          child: Container(
                            padding: EdgeInsets.all(width * 0.04),
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? const Color(0xFF234F68)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(width * 0.06),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.13,
                                  height: width * 0.13,
                                  decoration: ShapeDecoration(
                                    color: const Color.fromARGB(
                                      122,
                                      192,
                                      188,
                                      188,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        width * 0.065,
                                      ),
                                    ),
                                  ),
                                  child: Icon(
                                    selectedIndex == index
                                        ? Icons
                                              .location_on // selected → filled
                                        : Icons
                                              .location_on_outlined, // unselected → outlined
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(width: width * 0.05),
                                Expanded(
                                  child: Text(
                                    locations[index]
                                        .split(",")
                                        .first
                                        .trim(), // ⭐ only first word
                                    style: TextStyle(
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: width * 0.038,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8BC83F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                   
                    },
                    child: SizedBox(
                      width: width * 0.59,
                      height: height * 0.07,
                      child: Center(
                        child: Text(
                          "Choose location",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.02,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 🔹 ADD ADDRESS SHEET – PROFESSIONAL THEME
  void openAddAddressSheet(BuildContext context, Function(String) onSave) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    TextEditingController addressController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: width * 0.06,
            right: width * 0.06,
            top: height * 0.03,
            bottom: MediaQuery.of(context).viewInsets.bottom + height * 0.03,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 DRAG INDICATOR
              Container(
                width: width * 0.12,
                height: height * 0.005,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              SizedBox(height: height * 0.03),

              // 🔹 TITLE
              Text(
                "Add New Address",
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F4C6B),
                ),
              ),

              SizedBox(height: height * 0.03),

              // 🔹 ADDRESS FIELD
              TextField(
                controller: addressController,
                maxLines: 3,
                style: TextStyle(fontSize: width * 0.04),
                decoration: InputDecoration(
                  hintText: "Enter street and city",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 245, 247, 249),
                  contentPadding: EdgeInsets.all(width * 0.045),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: height * 0.04),

              // 🔹 SAVE BUTTON (THEME)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8BC83F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (addressController.text.trim().isNotEmpty) {
                    onSave(addressController.text.trim());
                    Navigator.pop(context);
                  }
                },
                child: SizedBox(
                  width: width * 0.7,
                  height: height * 0.065,
                  child: Center(
                    child: Text(
                      "Save Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.042,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final username = context.watch<Createprovider>().username;

    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
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
                          // 🔹 Dynamic Location Container
                          GestureDetector(
                            onTap: () {
                              openLocationBottomDrawer(context);
                            },
                            child: Container(
                              height: width * 0.12,
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: height * 0.022,
                                    color: const Color(0xFF1F4C6B),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Text(
                                    getSelectedLocationTitle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: width * 0.032,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1F4C6B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ⭐ THIS FIXES EVERYTHING
                          const Spacer(),

                          // 🔹 Notification Icon (FIXED)
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
                              color: const Color(0xFF1F4C6B),
                            ),
                          ),

                          SizedBox(width: width * 0.04),

                          // 🔹 Profile Icon (FIXED)
                          Container(
                            width: width * 0.12,
                            height: width * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.2,
                              ),
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
      ),
      drawer: DrawerButton(),
    );
  }
}
