import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentDeatail extends StatefulWidget {
  final Map<String, dynamic> property;
  final DateTime checkIn;
  final DateTime checkOut;
  final String? selectedPaymentMethod;
  final String? note;
  final Map<String, String>? appliedVoucher;
  final String? upiId;

  const PaymentDeatail({
    super.key,
    required this.property,
    required this.checkIn,
    required this.checkOut,
    required this.selectedPaymentMethod,
    required this.note,
    required this.appliedVoucher,
    required this.upiId,
  });

  @override
  State<PaymentDeatail> createState() => _PaymentDeatailState();
}

class _PaymentDeatailState extends State<PaymentDeatail> {
  String? currentUpiId;

  @override
  void initState() {
    super.initState();

    selectedPaymentMethod = widget.selectedPaymentMethod;

    selectedIndex = paymentMethods.indexWhere(
      (item) => item["name"] == selectedPaymentMethod,
    );

    currentUpiId = widget.upiId; // ✅ important

    if (currentUpiId != null) {
      upiController.text = currentUpiId!;
    }
  }

  int get numberOfDays {
    return widget.checkOut.difference(widget.checkIn).inDays;
  }

  int get price {
    String priceStr = widget.property['price']?.toString() ?? "0";

    priceStr = priceStr
        .toLowerCase()
        .replaceAll("k", "")
        .replaceAll("₹", "")
        .trim();

    return (int.tryParse(priceStr) ?? 0) * 1000;
  }

  double get dailyRent {
    return price / 30;
  }

  double get totalRent {
    return dailyRent * numberOfDays;
  }

  double get discountAmount {
    if (widget.appliedVoucher == null) return 0;

    String discountStr = widget.appliedVoucher!["discount"] ?? "0/0";

    List<String> parts = discountStr.split("/");

    if (parts.length == 2) {
      double percent = double.tryParse(parts[1]) ?? 0;

      return totalRent * percent / 100;
    }

    return 0;
  }

  double get finalAmount {
    return totalRent - discountAmount;
  }

  int selectedIndex = -1;
  String? selectedPaymentMethod;

  List<Map<String, String>> paymentMethods = [
    {"name": "Google Pay", "image": "assets/gpay.png"},
    {"name": "PayPal", "image": "assets/paypal.png"},
    {"name": "Apple Pay", "image": "assets/apple pay.png"},
    {"name": "upi", "image": "assets/upi.png"},
  ];

  TextEditingController upiController = TextEditingController();

  void openPaymentDrawer() {
    upiController.text = currentUpiId ?? "";

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                top: height * 0.02,
                bottom:
                    MediaQuery.of(context).viewInsets.bottom + height * 0.03,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔹 Drag Handle
                    Container(
                      width: width * 0.15,
                      height: height * 0.006,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // 🔹 Title
                    Text(
                      "Select Payment Method",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // 🔹 Payment Grid
                    GridView.builder(
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
                            setModalState(() {
                              selectedIndex = index;
                            });
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
                                    SizedBox(height: height * 0.05),
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
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        paymentMethods[index]["image"]!,
                                        height: height * 0.05,
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    if (selectedIndex != -1 &&
                        paymentMethods[selectedIndex]["name"]!.toLowerCase() ==
                            "upi")
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: height * 0.01,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔹 Already entered UPI
                            Text(
                              "Current UPI ID",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: height * 0.005),

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(width * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                currentUpiId ?? "No UPI ID",
                                style: TextStyle(
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            SizedBox(height: height * 0.02),

                            // 🔹 Change UPI
                            Text(
                              "Change UPI ID",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: height * 0.01),

                            TextField(
                              controller: upiController,
                              autofocus: false,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                labelText: "Enter UPI ID",
                                hintText: "example@upi",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.account_balance_wallet),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // 🔥 UPI TEXTFIELD (dynamic)
                    SizedBox(height: height * 0.03),

                    // 🔹 Select Button
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8BC83F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: selectedIndex == -1
                            ? null
                            : () {
                                String selectedName =
                                    paymentMethods[selectedIndex]["name"]!;

                                if (selectedName.toLowerCase() == "upi") {
                                  if (upiController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Please enter UPI ID"),
                                      ),
                                    );
                                    return;
                                  }

                                  if (!RegExp(
                                    r'^[\w.-]+@[\w]+$',
                                  ).hasMatch(upiController.text)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Invalid UPI ID"),
                                      ),
                                    );
                                    return;
                                  }
                                }
                                upiController.clear();
                                setState(() {
                                  selectedPaymentMethod = selectedName;

                                  // 🔥 UPDATE UPI VALUE HERE
                                  if (selectedName.toLowerCase() == "upi") {
                                    currentUpiId = upiController.text;
                                  }
                                });

                                Navigator.pop(context);
                              },
                        child: Text(
                          "Select",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                                    color: const Color(0xFF8BC83F),
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
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                top: height * 0.01,
                start: width * 0.05,
              ),
              child: Text(
                "Payment Detail",
                style: GoogleFonts.raleway(
                  color: const Color(0xFF242B5C),
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.54,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                top: height * 0.01,
                start: width * 0.05,
                end: width * 0.05,
              ),
              child: Row(
                children: [
                  Text(
                    "Period time",
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.54,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "$numberOfDays / day",
                    style: TextStyle(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.54,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                top: height * 0.01,
                start: width * 0.05,
                end: width * 0.05,
              ),
              child: Row(
                children: [
                  Text(
                    "Rent per month",
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.54,
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.property['price'] ?? "",
                    style: TextStyle(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.54,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.directional(
                top: height * 0.01,
                start: width * 0.05,
                end: width * 0.05,
              ),
              child: Row(
                children: [
                  Text(
                    "discount",
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.54,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${widget.appliedVoucher!["discount"] ?? ""}%",
                    style: TextStyle(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.04),

            Padding(
              padding: EdgeInsetsGeometry.directional(
                top: height * 0.01,
                start: width * 0.05,
                end: width * 0.05,
              ),
              child: Row(
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.lato(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.54,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "₹${totalRent.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.54,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                start: width * 0.05,
                end: width * 0.02,
                top: height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment method',
                    style: TextStyle(
                      color: const Color(0xFF242B5C),
                      fontSize: width * 0.060,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.54,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: height * 0.005),
                      TextButton(
                        onPressed: () {
                          openPaymentDrawer();
                        },
                        child: Text(
                          'Change',
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF242B5C),
                            fontSize: width * 0.039,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.015,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.015,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    // IMAGE
                    if (selectedIndex != -1)
                      Image.asset(
                        paymentMethods[selectedIndex]["image"]!,
                        height: height * 0.04,
                      ),

                    SizedBox(width: width * 0.03),

                    // NAME
                    Text(
                      selectedPaymentMethod ?? "Select Payment",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
