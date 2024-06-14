import 'package:flutter/material.dart';

class ProductListFarmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C7230), // Header color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // Back button color
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "List of Products",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Adjust vertical padding as needed
              child: Center(
                child: Image.asset(
                  'images/farmers/dummyproductlist.png', // Replace with actual image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Adjust vertical padding as needed
              child: Center(
                child: Image.asset(
                  'images/farmers/dummyproductlist.png', // Replace with actual image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Adjust vertical padding as needed
              child: Center(
                child: Image.asset(
                  'images/farmers/dummyproductlist.png', // Replace with actual image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
