// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:helen_app/buyers/order-buyer.dart';

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
                style: TextStyle(color: Color(0xFF0C7230)),
                decoration: InputDecoration(
                  hintText: 'Search Here...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                  fillColor: Color(0xFF0C7230).withOpacity(0.1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0C7230), // Outline border color
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF0C7230),
                  ),
                ),
              ),
              SizedBox(height: 20), // Adding some space between search bar and images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset('images/buyers/Carrot.png'),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderBuyer()),
                        );
                      },
                      child: Image.asset('images/buyers/Corn.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Adding some space between rows of images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset('images/buyers/Lemon.png'),
                  ),
                  Expanded(
                    child: Image.asset('images/buyers/Tomatoes.png'),
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