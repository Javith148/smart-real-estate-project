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


  
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

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
Column(
  children: [

    /// 🔹 TOP ROW
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        /// Google Pay
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = 0;
            });
          },
          child: Container(
            width: width * 0.42,
            height: height * 0.14,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selectedIndex == 0
                    ? Colors.green
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Stack(
              children: [

                /// Tick Icon
                if (selectedIndex == 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),

                /// Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_balance_wallet,
                        size: width * 0.09),
                    SizedBox(height: 8),
                    Text(
                      "Google Pay",
                      style: TextStyle(
                        fontSize: width * 0.035,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        /// PayPal
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = 1;
            });
          },
          child: Container(
            width: width * 0.42,
            height: height * 0.14,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selectedIndex == 1
                    ? Colors.green
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Stack(
              children: [

                if (selectedIndex == 1)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.check,
                          size: 16, color: Colors.white),
                    ),
                  ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.payment, size: width * 0.09),
                    SizedBox(height: 8),
                    Text(
                      "PayPal",
                      style: TextStyle(
                        fontSize: width * 0.035,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),

    SizedBox(height: height * 0.025),

    /// 🔹 BOTTOM ROW
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        /// Apple Pay
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = 2;
            });
          },
          child: Container(
            width: width * 0.42,
            height: height * 0.14,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selectedIndex == 2
                    ? Colors.green
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Stack(
              children: [

                if (selectedIndex == 2)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.check,
                          size: 16, color: Colors.white),
                    ),
                  ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.apple, size: width * 0.09),
                    SizedBox(height: 8),
                    Text(
                      "Apple Pay",
                      style: TextStyle(
                        fontSize: width * 0.035,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        /// Venmo
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = 3;
            });
          },
          child: Container(
            width: width * 0.42,
            height: height * 0.14,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selectedIndex == 3
                    ? Colors.green
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Stack(
              children: [

                if (selectedIndex == 3)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.check,
                          size: 16, color: Colors.white),
                    ),
                  ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wallet, size: width * 0.09),
                    SizedBox(height: 8),
                    Text(
                      "Venmo",
                      style: TextStyle(
                        fontSize: width * 0.035,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ],
)

          ],
        ),
      ),
    );
  }
}
