import 'package:flutter/material.dart';
import 'package:helen_app/farmers/agrikachat.dart';
import 'package:helen_app/farmers/product-list.dart';
import 'package:helen_app/farmers/upcoming-events.dart'; 
import 'package:helen_app/farmers/orderspage.dart'; // Import the OrdersPage class

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),

              // Orders Section
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersPage()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Added border radius
                    child: Stack(
                      children: [
                        Image.asset(
                          'images/farmers/orders.png',
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 120,
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
              SizedBox(height: 15),

              // List of Products Section
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductListFarmer()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Added border radius
                    child: Stack(
                      children: [
                        Image.asset(
                          'images/farmers/listofproduct.png', // Assuming same image for list of products
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 120,
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
              SizedBox(height: 15),

              // Upcoming Events Section
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpcomingEvents()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Added border radius
                    child: Stack(
                      children: [
                        Image.asset(
                          'images/farmers/events.png',
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 120,
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
              SizedBox(height: 15),

              // AgriKaChat Section
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatAI()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
                  height: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Added border radius
                    child: Stack(
                      children: [
                        Image.asset(
                          'images/farmers/agrikachat.png',
                          width: MediaQuery.of(context).size.width * 0.9,
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
      ),
    );
  }
}
