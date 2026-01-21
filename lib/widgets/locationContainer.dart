import 'package:flutter/material.dart';
import 'package:real_esate_finder/widgets/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Locationcontainer extends StatefulWidget {
  const Locationcontainer({super.key});

  @override
  State<Locationcontainer> createState() => _LocationcontainerState();
}

class _LocationcontainerState extends State<Locationcontainer> {
  List<String> locations = ["Coimatore,tamilNadu"];

  int selectedIndex = 0;

  Future<void> saveLocationsToPrefs(List<String> locations) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_locations', locations);
  }

  Future<void> saveSelectedIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_location_index', index);
  }

  Future<int> loadSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('selected_location_index') ?? 0;
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
    final savedLocations = await loadLocationsFromPrefs();
    final savedIndex = await loadSelectedIndex();

    if (savedLocations.isNotEmpty) {
      setState(() {
        locations = savedLocations;

        if (savedIndex < savedLocations.length) {
          selectedIndex = savedIndex;
        } else {
          selectedIndex = 0;
        }
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

                            if (locations.isEmpty) {
                              selectedIndex = -1;
                            } else if (selectedIndex >= locations.length) {
                              selectedIndex = 0;
                            }
                          });

                          await saveLocationsToPrefs(locations);
                          await saveSelectedIndex(selectedIndex);

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
                          onTap: () async {
                            setState(() {
                              selectedIndex = index;
                            });

                            await saveSelectedIndex(index);
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
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapWithAddress(),
                        ),
                      );

                      if (result != null &&
                          result.toString().trim().isNotEmpty) {
                        setState(() {
                          locations.add(result);
                          selectedIndex = locations.length - 1;
                        });

                        await saveLocationsToPrefs(locations);
                        await saveSelectedIndex(selectedIndex);
                        setModalState(() {});
                      }
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

    return  GestureDetector(
          onTap: () {
            openLocationBottomDrawer(context);
          },
          child: Container(
            height: width * 0.12,
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
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
                 SizedBox(width: width * 0.01),
                Icon(Icons.keyboard_arrow_down ,size: height * 0.015,color: const Color(0xFF1F4C6B),)
              ],
            ),
          ),
   
    );
  }
}
