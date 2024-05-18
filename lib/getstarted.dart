// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStartedPage(),
    );
  }
}

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          ClipPath(
            clipper: GreenClipper(),
            child: Container(
              color: Color(0xFF0C7230), // Changed to hexadecimal color
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          // Content
          Column(
            children: [
              // Image
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Center(
                  child: Image.asset(
                    'images/white-helen.png', // Your provided image path
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ),
              // Text content and button on white background
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Kaagapay mo at KA-HELEN',
                      style: TextStyle(
                        fontFamily: 'Poppins', // Use the Poppins font
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Gabay sa Pamimili, Kaagapay sa Pagsasaka, Kakampi sa Pag-unlad.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins', // Use the Poppins font
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF0C7230), // Changed to hexadecimal color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 80,
                        ),
                      ),
                      child: Text(
                        'Simulan Na!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins', // Use the Poppins font
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ], 
          ),
        ],
      ),
    );
  }
}

class GreenClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.75); 
    path.quadraticBezierTo(0, size.height, size.width * 0.25, size.height);  
    path.lineTo(size.width * 0.75, size.height); 
    path.quadraticBezierTo(size.width, size.height, size.width, size.height * 0.75); 
    path.lineTo(size.width, 0); 
    path.lineTo(0, 0); 
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
