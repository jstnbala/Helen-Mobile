// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/farmers/agrikachat_module/agrikachat.dart';
import 'package:helen_app/src/views/screens/navbar/farmer-navbar.dart';
import 'package:helen_app/src/views/screens/farmers/listofproducts_module/product-list.dart';
import 'package:helen_app/src/views/screens/farmers/upcoming_events_module/upcoming-events.dart';  

class HomePageFarmer extends StatelessWidget {
  const HomePageFarmer({super.key});

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
                    MaterialPageRoute(builder: (context) => FarmerNavbar(initialIndex: 2)
                    ), 
                  );
                },
                child: SizedBox(
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
                child: SizedBox(
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
                child: SizedBox(
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
                            children: const [
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
                child: SizedBox(
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
