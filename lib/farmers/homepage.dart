import 'package:flutter/material.dart';
import 'package:helen_app/farmers/agri-tech.dart';
import 'package:helen_app/farmers/agrikachat.dart';
import 'package:helen_app/farmers/product-list.dart';
import 'package:helen_app/farmers/upcoming-events.dart';
import 'package:helen_app/farmers/addproduct.dart'; // Import the AddProductPage class
import 'package:helen_app/farmers/orderspage.dart'; // Import the OrdersPage class

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Orders Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrdersPage()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 185,
                        height: 140,
                        child: Stack(
                          children: [
                            Image.asset(
                              'images/farmers/order.png',
                              width: 185,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 10,
                              left: 15,
                              child: Text(
                                'Orders',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 15,
                              child: Text(
                                '00',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Add Product Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProductPage()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 185,
                        height: 140,
                        child: Stack(
                          children: [
                            Image.asset(
                              'images/farmers/addproduct.png',
                              width: 185,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 10,
                              left: 15,
                              child: Text(
                                'Add Product',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
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
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // List of Products Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductListFarmer()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 185,
                        height: 140,
                        child: Stack(
                          children: [
                            Image.asset(
                              'images/farmers/addproduct.png', // Assuming same image for list of products
                              width: 185,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 10,
                              left: 15,
                              child: Text(
                                'List of Products',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Upcoming Events Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpcomingEvents()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 185,
                        height: 140,
                        child: Stack(
                          children: [
                            Image.asset(
                              'images/farmers/upcomingevents.png',
                              width: 185,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 10,
                              left: 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Upcoming',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    'Events',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
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
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Choose an option",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF0C7230),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChatAI()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF0C7230),
                                  ),
                                  child: Container(
                                    width: double.infinity, // Align the width of the button
                                    child: Center(
                                      child: Text(
                                        "Continue to AgriKaChat",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AgriTechnician()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF0C7230),
                                  ),
                                  child: Container(
                                    width: double.infinity, // Align the width of the button
                                    child: Center(
                                      child: Text(
                                        "Message Agri-Technician",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
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
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 185,
                        height: 140,
                        child: Stack(
                          children: [
                            Image.asset(
                              'images/farmers/aichat.png',
                              width: 185,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 10,
                              left: 15,
                              child: Text(
                                'AgriKaChat',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}
