import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_esate_finder/homepage.dart';
import 'CreateProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  bool isGridView = true;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Createprovider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    void _showDeleteDialog(BuildContext context, Map<String, dynamic> item) {
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔹 ICON
                  Container(
                    width: width * 0.18,
                    height: width * 0.18,
                    decoration: BoxDecoration(
                      color: const Color(0xFF234F68).withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: const Color(0xFF234F68),
                      size: width * 0.09,
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // 🔹 TITLE
                  Text(
                    "Delete ${item['title']}",
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F4C6B),
                    ),
                  ),

                  SizedBox(height: height * 0.012),

                  // 🔹 MESSAGE
                  Text(
                    "Are you sure you want to delete this  ${item['title']}?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  // 🔹 BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF1F4C6B)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.03),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.016,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: const Color(0xFF1F4C6B),
                              fontWeight: FontWeight.w600,
                              fontSize: width * 0.038,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: width * 0.03),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF234F68),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.03),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.016,
                            ),
                          ),
                          onPressed: () {
                            Provider.of<Createprovider>(
                              context,
                              listen: false,
                            ).removeFromCart(item);

                            Navigator.pop(context);
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: width * 0.038,
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

    void _clearallitem(BuildContext screenContext) {
      final width = MediaQuery.of(screenContext).size.width;
      final height = MediaQuery.of(screenContext).size.height;

      showDialog(
        context: screenContext,
        barrierDismissible: false,
        builder: (dialogContext) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: width * 0.18,
                    height: width * 0.18,
                    decoration: BoxDecoration(
                      color: const Color(0xFF234F68).withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: const Color(0xFF234F68),
                      size: width * 0.09,
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  Text(
                    "Clear All Favorites",
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F4C6B),
                    ),
                  ),

                  SizedBox(height: height * 0.012),

                  Text(
                    "Are you sure you want to remove all favorites?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF1F4C6B),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(screenContext).size.width * 0.03,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(screenContext).size.height *
                                  0.016,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: const Color(0xFF1F4C6B),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(screenContext).size.width *
                                  0.038,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: width * 0.03),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF234F68),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(screenContext).size.width * 0.03,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(screenContext).size.height *
                                  0.016,
                            ),
                            elevation: 2,
                          ),
                          onPressed: () {
                            Provider.of<Createprovider>(
                              screenContext, // correct context
                              listen: false,
                            ).clearall();

                            Navigator.pop(dialogContext);
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(screenContext).size.width *
                                  0.038,
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "My Favorite",
          style: GoogleFonts.lato(fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.directional(end: width * 0.04),
            child: IconButton(
              onPressed: () {
                cart.cartItems.isEmpty
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("your favorite is empty")),
                      )
                    : _clearallitem(context);
              },

              icon: Icon(Icons.delete_outlined),
            ),
          ),
        ],
      ),
      body: cart.cartItems.isEmpty
          ? Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    start: width * 0.06,
                    end: width * 0.00,
                  ),
                  child: Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${cart.cartItems.length} Estate',
                              style: TextStyle(
                                color: const Color(0xFF204D6C),
                                fontSize: width * 0.060,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w300,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: width * 0.52),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.grid_view_rounded,
                              color: isGridView
                                  ? const Color(0xFF204D6C)
                                  : Colors.grey,
                            ),
                            onPressed: () => setState(() => isGridView = true),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.list,
                              color: !isGridView
                                  ? const Color(0xFF204D6C)
                                  : Colors.grey,
                            ),
                            onPressed: () => setState(() => isGridView = false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Image.asset("assets/fav_icon.png"),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Your favorite page is \n',
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF234F68),
                                  fontSize: width * 0.08,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'empty',
                                style: TextStyle(
                                  color: const Color(0xFF234F68),
                                  fontSize: width * 0.08,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          "Click add button above to start exploring and choose \n your favorite estates.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(fontSize: width * 0.03),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.directional(
                      start: width * 0.06,
                      end: width * 0.00,
                    ),
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${cart.cartItems.length} Estate',
                                style: TextStyle(
                                  color: const Color(0xFF204D6C),
                                  fontSize: width * 0.060,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w300,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.52),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.grid_view_rounded,
                                color: isGridView
                                    ? const Color(0xFF204D6C)
                                    : Colors.grey,
                              ),
                              onPressed: () =>
                                  setState(() => isGridView = true),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.list,
                                color: !isGridView
                                    ? const Color(0xFF204D6C)
                                    : Colors.grey,
                              ),
                              onPressed: () =>
                                  setState(() => isGridView = false),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: width * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: isGridView
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio:
                                      (width * 0.45) / (height * 0.32),
                                ),

                            itemCount: cart.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cart.cartItems[index];

                              return GestureDetector(
                                onLongPress: () {
                                  _showDeleteDialog(
                                    context,
                                    cart.cartItems[index],
                                  );
                                },

                                child: Card(
                                  child: Container(
                                    width: width * 0.45,
                                    height: height * 0.3,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(186, 244, 242, 242),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                item["image"],
                                                height: height * 0.23,
                                                width: width * 0.4,
                                                fit: BoxFit.contain,
                                              ),

                                              Positioned(
                                                left: width * 0.032,
                                                top: height * 0.022,
                                                child: Container(
                                                  width: width * 0.06,
                                                  height: width * 0.06,
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Color(
                                                          0xFF8BC83F,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                    size: height * 0.01,
                                                  ),
                                                ),
                                              ),

                                              Positioned(
                                                bottom: height * 0.025,
                                                right: width * 0.03,
                                                child: Container(
                                                  height: height * 0.045,
                                                  width: width * 0.18,
                                                  decoration: ShapeDecoration(
                                                    color: Color.fromARGB(
                                                      214,
                                                      35,
                                                      79,
                                                      104,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          item["price"],
                                                          style:
                                                              GoogleFonts.montserrat(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                    0.035,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                top:
                                                                    height *
                                                                    0.005,
                                                              ),
                                                          child: Text(
                                                            "/month",
                                                            style:
                                                                GoogleFonts.montserrat(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                      0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: width * 0.04,
                                          ),
                                          child: Text(
                                            item["title"],
                                            style: GoogleFonts.raleway(
                                              color: Color(0xFF242B5C),
                                              fontSize: width * 0.05,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                        SizedBox(height: height * 0.005),

                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: width * 0.03,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: height * 0.02,
                                              ),
                                              SizedBox(width: width * 0.01),

                                              Text(
                                                item["rating"],
                                                style: GoogleFonts.montserrat(
                                                  color: Color(0xFF234F68),
                                                  fontSize: width * 0.03,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),

                                              SizedBox(width: width * 0.03),

                                              Icon(
                                                Icons.location_on,
                                                size: height * 0.015,
                                                color: Color(0xFF1F4C6B),
                                              ),

                                              SizedBox(width: width * 0.01),

                                              Text(
                                                item["location"],
                                                style: TextStyle(
                                                  fontSize: width * 0.025,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF1F4C6B),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: cart.cartItems.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = cart.cartItems[index];

                              return Padding(
                                padding: EdgeInsets.only(bottom: height * 0.02),
                                child: Slidable(
                                  key: ValueKey(item["title"]),

                                  // 🔹 40% swipe only
                                  endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    extentRatio: 0.4, // 👈 40% STOP HERE

                                    children: [
                                      CustomSlidableAction(
                                        onPressed: (_) {
                                          setState(() {
                                            cart.cartItems.removeAt(index);
                                          });
                                        },
                                        backgroundColor: const Color(
                                          0xFF1F4C6B,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // 🔹 YOUR CARD (NO CHANGE)
                                  child: Container(
                                    width: width * 0.9,
                                    height: height * 0.25,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        186,
                                        244,
                                        242,
                                        242,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.03,
                                                vertical: height * 0.02,
                                              ),
                                              child: Image.asset(
                                                item["image"],
                                                height: height * 0.25,
                                                fit: BoxFit.fill,
                                              ),
                                            ),

                                            Positioned(
                                              left: width * 0.052,
                                              top: height * 0.032,
                                              child: Container(
                                                width: width * 0.08,
                                                height: width * 0.08,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF8BC83F),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                  size: height * 0.015,
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              top: height * 0.165,
                                              left: width * 0.058,
                                              child: SizedBox(
                                                width: width * 0.24,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF234F68),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Apartment",
                                                    style: GoogleFonts.raleway(
                                                      color: Colors.white,
                                                      fontSize: width * 0.025,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width: width * 0.02),

                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: height * 0.03,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * 0.35,
                                                child: Text(
                                                  item["title"],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: GoogleFonts.raleway(
                                                    color: const Color(
                                                      0xFF234F68,
                                                    ),
                                                    fontSize: width * 0.045,
                                                    fontWeight: FontWeight.w800,
                                                    letterSpacing: 0.54,
                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: height * 0.01),

                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: height * 0.02,
                                                  ),
                                                  SizedBox(width: width * 0.01),
                                                  Text(
                                                    item["rating"],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          color: const Color(
                                                            0xFF234F68,
                                                          ),
                                                          fontSize:
                                                              width * 0.045,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: height * 0.01),

                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: height * 0.020,
                                                    color: const Color(
                                                      0xFF1F4C6B,
                                                    ),
                                                  ),
                                                  SizedBox(width: width * 0.01),
                                                  Text(
                                                    item["location"],
                                                    style: TextStyle(
                                                      fontSize: width * 0.035,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: const Color(
                                                        0xFF1F4C6B,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: height * 0.03),

                                              Row(
                                                children: [
                                                  Text(
                                                    item["price"],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          color: const Color(
                                                            0xFF234F68,
                                                          ),
                                                          fontSize:
                                                              width * 0.06,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: height * 0.01,
                                                    ),
                                                    child: Text(
                                                      " / month",
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            color: const Color(
                                                              0xFF234F68,
                                                            ),
                                                            fontSize:
                                                                width * 0.035,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
