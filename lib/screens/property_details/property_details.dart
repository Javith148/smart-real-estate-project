import 'package:flutter/material.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PropertyDetails extends StatefulWidget {
  final Map<String, dynamic> property;

  const PropertyDetails({super.key, required this.property});

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body:SingleChildScrollView(child: 
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(width * 0.03),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    widget.property['image'],
                    height: height * 0.55,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: height * 0.02,
                  left: width * 0.03,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: width * 0.12,
                      height: width * 0.12,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: width * 0.05,
                        color: Color(0xFF1F4C6B),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.02,
                  right: width * 0.2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: width * 0.12,
                      height: width * 0.12,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.ios_share,
                        size: width * 0.05,
                        color: Color(0xFF1F4C6B),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: height * 0.02,
                  right: width * 0.05,
                  child: Consumer<Createprovider>(
                    builder: (context, cart, child) {
                      bool isAdded = cart.isInCart(widget.property);

                      return InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          if (isAdded) {
                            cart.removeFromCart(widget.property);
                          } else {
                            cart.addToCart(widget.property);
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: width * 0.12,
                          height: width * 0.12,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isAdded
                                ? const Color(0xFF8BC83F)
                                : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            isAdded ? Icons.favorite : Icons.favorite_border,
                            color: isAdded ? Colors.white : Colors.pinkAccent,
                            size: width * 0.06,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: height * 0.02,
                  left: width * 0.04,
                  child: Container(
                    height: height * 0.053,
                    width: width * 0.23,
                    decoration: ShapeDecoration(
                      color: Color.fromARGB(214, 35, 79, 104),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          SizedBox(width: width * 0.01),
                          Text(
                            widget.property['rating'],
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: height * 0.02,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: height * 0.02,
                  left: width * 0.3,
                  child: Container(
                    height: height * 0.055,
                    width: width * 0.25,
                    decoration: ShapeDecoration(
                      color: Color.fromARGB(214, 35, 79, 104),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.property['property-type'],
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: height * 0.011,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.directional(
              top: height * 0.02,
              start: width * 0.06,
              end: width * 0.04,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.property['title'],
                      style: GoogleFonts.lato(
                        color: Color(0xFF1F4C6B),
                        fontSize: height * 0.04,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: height * 0.02,
                          color: Color(0xFF1F4C6B),
                        ),

                        SizedBox(width: width * 0.005),

                        Text(
                          widget.property["location"],
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F4C6B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),
                Column(
              
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.property['price']}',
                      style: GoogleFonts.lato(
                        color: Color(0xFF1F4C6B),
                        fontSize: height * 0.04,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                   

                    Text(
                      'per month',
                      style: GoogleFonts.lato(
                        color: Color(0xFF1F4C6B),
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
       ) ),
    );
  }
}
