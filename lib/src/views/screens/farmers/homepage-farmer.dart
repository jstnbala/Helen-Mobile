// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/farmers/agrikachat_module/agrikachat.dart';
import 'package:helen_app/src/views/common/navbar.dart';
import 'package:helen_app/src/views/screens/farmers/listofproducts_module/product-list.dart';
import 'package:helen_app/src/views/screens/farmers/upcoming_events_module/upcoming-events.dart';  

class HomePageFarmer extends StatelessWidget {
  const HomePageFarmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5), // Dirty white background color
        child: SingleChildScrollView(
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
                      MaterialPageRoute(
                        builder: (context) => NavBar(initialIndex: 2),
                      ),
                    );
                  },
                  child: Center( // Wrap in Center to align horizontally
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Added border radius
                        child: Stack(
                          children: [
                            Image.asset(
                              'images/Orders.png',
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 100,
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
                                  shadows: const [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black,
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
                  child: Center( // Wrap in Center to align horizontally
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Added border radius
                        child: Stack(
                          children: [
                            Image.asset(
                              'images/List of Products.png', // Assuming same image for list of products
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 100,
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
                                  shadows: const [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black,
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
                ),
                SizedBox(height: 15),

                // Upcoming Events and Projects Section
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensures equal spacing between the sections
  children: [
    // Upcoming Events Section
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpcomingEvents()),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.42, // Adjusted width
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Added border radius
          child: Stack(
            children: [
              Image.asset(
                'images/Events.png',
                width: MediaQuery.of(context).size.width * 0.42,
                height: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 10,
                left: 15,
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15, // Adjusted font size
                    shadows: const [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black,
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

    // Projects Section
    GestureDetector(
      onTap: () {
        // Add navigation for Projects section here
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.42, // Adjusted width
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Added border radius
          child: Stack(
            children: [
              Image.asset(
                'images/Projects.png',
                width: MediaQuery.of(context).size.width * 0.9,
                height: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 10,
                left: 15,
                child: Text(
                  'Projects',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Adjusted font size
                    shadows: const [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black,
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
  ],
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
                  child: Center( // Wrap in Center to align horizontally
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Added border radius
                        child: Stack(
                          children: [
                            Image.asset(
                              'images/AgriKaChat.png',
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
                                  shadows: const [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}