// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/direct-product_details.dart';

class HomePageBuyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                style: TextStyle(color: Color(0xFFCA771A)),
                decoration: InputDecoration(
                  hintText: 'Search Here...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                  fillColor: Color(0xFFCA771A).withOpacity(0.1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFCA771A), // Outline border color
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFCA771A),
                  ),
                ),
              ),
              SizedBox(height: 20), // Adding space between search bar and cards
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 5, // Adding shadow to the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Icon(Icons.image, size: 120, color: Colors.grey),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Okra',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFFCA771A),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Kilos',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFCA771A),
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'P40.00',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFCA771A),
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SampleTomatoesClass()),
                        );
                      },
                      child: Card(
                        elevation: 5, // Adding shadow to the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Icon(Icons.image, size: 120, color: Colors.grey),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tomato',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFFCA771A),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Kilos',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFCA771A),
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'P25.00',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFCA771A),
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10), // Adding space between rows
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 5, // Adding shadow to the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Icon(Icons.image, size: 120, color: Colors.grey),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Carrot',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFFCA771A),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Kilos',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFCA771A),
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'P100.00',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFCA771A),
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Card(
                      elevation: 5, // Adding shadow to the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Icon(Icons.image, size: 120, color: Colors.grey),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lemon',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFFCA771A),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Kilos',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFCA771A),
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'P30.00',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFCA771A),
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

