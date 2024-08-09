import 'package:flutter/material.dart';

class PreviousOrdersBuyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0), // Radius for the lower left corner
            bottomRight: Radius.circular(20.0), // Radius for the lower right corner
          ),
          child: AppBar(
            backgroundColor: Color(0xFFCA771A), // Header color
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Previous Orders',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white, // Set text color to white
              ),
            ),
            centerTitle: true, // Center the title text
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Wrap the Icon widget with a Container and provide a background color and border radius
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFCA771A), // Background color
              borderRadius: BorderRadius.circular(50.0), // Border radius
            ),
            padding: EdgeInsets.all(20.0), // Adjust padding as needed
            child: Icon(
              Icons.shopping_cart,
              size: 100.0,
              color: Colors.white, // Icon color
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'There are no order history yet. Start purchasing some products.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Color(0xFFCA771A),
            ),
          ),
        ],
      ),
    );
  }
}
