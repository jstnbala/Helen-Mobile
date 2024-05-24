// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:helen_app/nav-bar.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'images/login-bg.jpg',
              fit: BoxFit.cover,
              height: size.height, // Match the screen height
            ),
          ),
          // Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Color(0xFF0C7230).withOpacity(0.7), // Adjust the opacity here
            ),
          ),
          // Login form with header
          SingleChildScrollView(
            child: Container(
              height: size.height, // Set container height to screen height
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15), // Add some space at the top
                    // Centered header with logos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 140, // Adjust height of logo
                          child: Image.asset('images/white-helen.png'),
                        ),
                        SizedBox(width: 3), // Add some space between the logos
                        SizedBox(
                          height: 140, // Adjust height of logo
                          child: Image.asset('images/logo-opa.png'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Add some space between logos and text
                    // "Mabuhay, Magsasaka!" text
                    Text(
                      'Mabuhay, Magsasaka!',
                      style: TextStyle(
                        fontSize: 28, // Make text bigger
                        fontWeight: FontWeight.bold, // Make text bold
                        color: Colors.white, // Set text color to white
                        fontFamily: 'Poppins', // Set font to Poppins
                      ),
                    ),
                    SizedBox(height: 8), // Add some space between lines
                    // "Mangyaring mag-log in gamit ang iyong mga kredensyal sa ibaba" text
                    Text(
                      'Mangyaring mag-log in gamit ang iyong mga kredensyal sa ibaba',
                      style: TextStyle(
                        fontSize: 16, // Make text smaller
                        color: Colors.white, // Set text color to white
                        fontFamily: 'Poppins', // Set font to Poppins
                      ),
                      textAlign: TextAlign.center, // Align text center
                    ),
                    SizedBox(height: 50), // Add some space between text and form
                    Center(
                      child: Container(
                        width: size.width * 0.8, // Set width to 80% of the screen width
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0), // Increase padding
                            labelText: 'Username',
                            hintText: 'Enter your username',
                            labelStyle: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                            hintStyle: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white, width: 2.0), // Increase border width
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0), // Increase border width
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0), // Increase border width
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: size.width * 0.8, // Set width to 80% of the screen width
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0), // Increase padding
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            labelStyle: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                            hintStyle: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white, width: 2.0), // Increase border width
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0), // Increase border width
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0), // Increase border width
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                          obscureText: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 8), // Add some space between password field and Forgot Password text
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: TextButton(
                          onPressed: () {
                            // Handle Forgot Password logic here
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: size.width * 0.7, // Set width to 70% of the screen width
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to HomeFarmerSeller
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Navbar()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: Colors.white),
                            ),
                          ),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Color(0xFF0C7230),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold, // Make text bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Additional text below the login button
                    Text(
                      'Walang account? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Mag-register lamang dito.',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Footer text
                    Text(
                      '© 2024 Helen. All Rights Reserved',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
