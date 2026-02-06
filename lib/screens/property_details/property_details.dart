import 'package:flutter/material.dart';
import 'package:real_esate_finder/CreateProvider.dart';
import 'package:provider/provider.dart';

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

      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(width * 0.03),
            child: Stack(
              children: [
                Image.asset(
                  widget.property['image'],
                  height: height * 0.5,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  top: height * 0.03,
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
                  top: height * 0.03,
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
                  top: height * 0.03,
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
                  bottom: height * 0.025,
                  right: width * 0.03,
                  child: Container(
                    height: height * 0.045,
                    width: width * 0.18,
                    decoration: ShapeDecoration(
                      color: Color.fromARGB(214, 35, 79, 104),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Center(child: Text("")),
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
