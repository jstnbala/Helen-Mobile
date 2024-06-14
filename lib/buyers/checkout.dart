// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isDeliverySelected = false;
  bool isPickupSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C7230),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: Text(
          "Checkout",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'images/buyers/product-corn.png',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Corn",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Kilos",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "P00.00",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quantity",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.remove, color: Colors.black),
                          onPressed: () {
                            // Decrease quantity
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "1",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add, color: Colors.black),
                          onPressed: () {
                            // Increase quantity
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Options",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: isDeliverySelected ? Color(0xFF0C7230) : Colors.grey[300],
                      ),
                      onPressed: () {
                        setState(() {
                          isDeliverySelected = true;
                          isPickupSelected = false;
                        });
                      },
                      child: Text(
                        "Delivery",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDeliverySelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: isPickupSelected ? Color(0xFF0C7230) : Colors.grey[300],
                      ),
                      onPressed: () {
                        setState(() {
                          isDeliverySelected = false;
                          isPickupSelected = true;
                        });
                      },
                      child: Text(
                        "Pickup",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isPickupSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (isDeliverySelected) buildDeliverySection(),
              if (isPickupSelected) buildPickupSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDeliverySection() {
    return Column(
      children: [
        Divider(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Delivery Address: 123 Sample Address, Consumer's Address City",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Delivery Date: 00/00/00",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        Divider(),
        buildSummaryRow("Subtotal (# items)", "00.00"),
        buildSummaryRow("Delivery Fee", "00.00"),
        buildSummaryRow("Total", "00.00", isTotal: true),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildActionButton("Cancel"),
            buildActionButton("Confirm"),
          ],
        ),
      ],
    );
  }

  Widget buildPickupSection() {
    return Column(
      children: [
        Divider(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Pickup Address: 123 Sample Address, Lucban Quezon Province.",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Pickup Dates",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          items: [],
          onChanged: (value) {
            // Handle change
          },
          icon: Icon(Icons.calendar_today),
        ),
        Divider(),
        buildSummaryRow("Subtotal (# items)", "00.00"),
        buildSummaryRow("Total", "00.00", isTotal: true),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildActionButton("Cancel"),
            buildActionButton("Confirm"),
          ],
        ),
      ],
    );
  }

  Widget buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isTotal ? 20 : 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildActionButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[300],
      ),
      onPressed: () {
        setState(() {
          // Handle button press
        });
      },
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
