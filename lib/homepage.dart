// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15),
          Card(
            color: Colors.transparent,
            elevation: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 370,
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/clouds.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 185,
                  height: 140,
                  child: Stack(
                    children: [
                      Image.asset(
                        'images/order.png',
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
              SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 185,
                  height: 140,
                  child: Stack(
                    children: [
                      Image.asset(
                        'images/addproduct.png',
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
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 185,
                  height: 140,
                  child: Stack(
                    children: [
                      Image.asset(
                        'images/upcomingevents.png',
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
              SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 185,
                  height: 140,
                  child: Stack(
                    children: [
                      Image.asset(
                        'images/aichat.png',
                        width: 185,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        left: 15,
                        child: Text(
                          'AI Chat',
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
            ],
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF0C7230),
              borderRadius: BorderRadius.circular(20), // Added border radius
            ),
            height: 315,
            width: 371,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'List of Products',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Card(
                              color: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'images/lemon.png',
                                      width: 500,
                                      height: 170, // Increased height
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Lemon',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            '10 Kilos',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Text(
                                'P00.00',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Stack(
                          children: [
                            Card(
                              color: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'images/lemon.png',
                                      width: 500,
                                      height: 170, // Increased height
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Lemon',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            '10 Kilos',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Text(
                                'P00.00',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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