import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> property;
  const PaymentPage({super.key, required this.property});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsetsGeometry.directional(
            start: width * 0.06,
            top: height * 0.02,
          ),
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
        title: Padding(
          padding: EdgeInsetsGeometry.directional(top: height * 0.02),
          child: Text(
            "Transaction review",
            style: GoogleFonts.lato(fontWeight: FontWeight.w700),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            Center(
              child: Container(
                width: width * 0.95,
                height: height * 0.25,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(186, 244, 242, 242),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.02,
                            ),
                            child: Image.asset(
                              widget.property['image'],
                              height: height * 0.25,
                              width: width * 0.5,
                              fit: BoxFit.fill,
                            ),
                          ),
                          
                          Positioned(
                            bottom: height *0.03,
                            left: width * 0.058,
                            child: Container(
                              width: width * 0.24,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color(0xFF234F68),
                                ),
                                onPressed: () {},
                                child: Text(
                                  widget.property['property-type'],
                                  style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontSize: width * 0.025,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: height * 0.03,
                            right: width * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.property['title'],
                                maxLines: 2, 
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF234F68),
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.54,
                                ),
                              ),

                              SizedBox(height: height * 0.01),

                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: height * 0.020,
                                    color: const Color(0xFF1F4C6B),
                                  ),
                                  SizedBox(width: width * 0.01),
                                  Expanded(
                                    
                                    child: Text(
                                       widget.property['location'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1F4C6B),
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              ),
Spacer(),
                             
                            Padding(padding: EdgeInsetsGeometry.directional(end: width*0.02,bottom: height*0.02),child: 
                             Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                  Container(
                          height: height * 0.038,
                          width: width * 0.18,
                          decoration: ShapeDecoration(
                            color: Color.fromARGB(213, 189, 193, 196),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: 
                          Center(child: 
                          Text("Rent", style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: width * 0.035,
                                    fontWeight: FontWeight.w600,
                                  ),)
                          ))
                              ],
                                  )     )
                            ],
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
    );
  }
}
