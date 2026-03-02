import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> property;
  const PaymentPage({super.key, required this.property});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {


  DateTime? checkInDate;
  DateTime? checkOutDate;
  int selectedIndex = 0;
  String? selectedPaymentMethod;


  
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }


  final List<Map<String, String>> paymentMethods = [
  {
    "name": "Google Pay",
    "image": "assets/gpay.png",
  },
  {
    "name": "PayPal",
    "image": "assets/paypal.png",
  },
  {
    "name": "Apple Pay",
    "image": "assets/apple pay.png",
  },
  {
    "name": "upi",
    "image": "assets/upi.png",
  },
];

  Future<void> selectCheckIn() async {
    final today = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(2100),
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        checkInDate = picked;
      });
    }
  }

  Future<void> selectCheckOut() async {
    if (checkInDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select Check-In first")),
      );
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: checkInDate!,
      firstDate: checkInDate!,
      lastDate: DateTime(2100),
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        checkOutDate = picked;
      });
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            bottom: height * 0.03,
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

                              Padding(
                                padding: EdgeInsetsGeometry.directional(
                                  end: width * 0.02,
                                  bottom: height * 0.02,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: height * 0.038,
                                      width: width * 0.18,
                                      decoration: ShapeDecoration(
                                        color: Color.fromARGB(
                                          213,
                                          189,
                                          193,
                                          196,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Rent",
                                          style: GoogleFonts.lato(
                                            color: Colors.black,
                                            fontSize: width * 0.035,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                top: height * 0.01,
                start: width * 0.05,
              ),
              child: Text(
                'Period',
                style: GoogleFonts.raleway(
                  color: const Color(0xFF242B5C),
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.54,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: selectCheckIn,
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.38,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 239, 239),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month),
                        SizedBox(width: width * 0.02),
                        Text(
                          checkInDate == null
                              ? "Check In"
                              : formatDate(checkInDate!),
                          style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: width * 0.08),

                GestureDetector(
                  onTap: selectCheckOut,
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.38,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 239, 239),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month),
                        SizedBox(width: width * 0.02),
                        Text(
                          checkOutDate == null
                              ? "Check Out"
                              : formatDate(checkOutDate!),
                          style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsetsGeometry.directional(
                top: height * 0.03,
                start: width * 0.05,
              ),
              child: Text(
                'Note for Owner',
                style: GoogleFonts.lato(
                  color: const Color(0xFF242B5C),
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.54,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(top: height * 0.02),
              child: Center(
                child: Container(
                  width: width * 0.85,
                  height: height * 0.065,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EFEF),
                    borderRadius: BorderRadius.circular(width * 0.06),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.05),

                      Icon(
                        Icons.message,
                        size: width * 0.05,
                        color: const Color(0xFF234F68),
                      ),

                      SizedBox(width: width * 0.02),

                      Expanded(
                        child: TextField(
                          style: TextStyle(fontSize: width * 0.04),
                          decoration: InputDecoration(
                            hintText: "Write your note in here",
                            hintStyle: TextStyle(
                              fontSize: width * 0.038,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                top: height * 0.03,
                start: width * 0.05,
              ),
              child: Text(
                'Payment Method',
                style: GoogleFonts.lato(
                  color: const Color(0xFF242B5C),
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.54,
                ),
              ),
            ),
Padding(
  padding: EdgeInsets.symmetric(vertical: height * 0.02,horizontal: width * 0.05),
  child: GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: paymentMethods.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: width * 0.05,
      mainAxisSpacing: height * 0.02,
      childAspectRatio: 1.2,
    ),
    itemBuilder: (context, index) {
      return GestureDetector(
       onTap: () {
  setState(() {
    selectedIndex = index;
    selectedPaymentMethod = paymentMethods[index]["name"];
  });

  print("Selected Payment: $selectedPaymentMethod");
},
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEDEDED),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selectedIndex == index
                  ? Colors.green
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [

             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: height * 0.05,),
              if (selectedIndex == index)
                 CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: width * 0.04),
                  ]
                  
                ),


              Expanded(child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Image.asset(
                    paymentMethods[index]["image"]!,
                    height: height * 0.05,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    paymentMethods[index]["name"]!,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),)
            ],
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
