// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';

class FarmerRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // Set icon color to white
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Farmer Registration',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set text color to white
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0C7230),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, MediaQuery.of(context).viewInsets.bottom + 30.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Add border radius
                ),
                labelStyle: TextStyle(fontFamily: 'Poppins'), // Set Poppins font
              ),
              style: TextStyle(fontFamily: 'Poppins'), // Set Poppins font for entered text
              textInputAction: TextInputAction.next,
              onTap: () {
                Scrollable.ensureVisible(context);
              },
            ),
            SizedBox(height: 10), // Add space between fields
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Add border radius
                ),
                labelStyle: TextStyle(fontFamily: 'Poppins'), // Set Poppins font
              ),
              style: TextStyle(fontFamily: 'Poppins'), // Set Poppins font for entered text
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10), // Add space between fields
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Enter your address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Add border radius
                ),
                labelStyle: TextStyle(fontFamily: 'Poppins'), // Set Poppins font
              ),
              style: TextStyle(fontFamily: 'Poppins'), // Set Poppins font for entered text
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10), // Add space between fields
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Organization',
                hintText: 'Your organization',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Add border radius
                ),
                labelStyle: TextStyle(fontFamily: 'Poppins'), // Set Poppins font
              ),
              style: TextStyle(fontFamily: 'Poppins'), // Set Poppins font for entered text
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10), // Add space between fields
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Contact',
                hintText: 'Enter your contact number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Add border radius
                ),
                labelStyle: TextStyle(fontFamily: 'Poppins'), // Set Poppins font
              ),
              style: TextStyle(fontFamily: 'Poppins'), // Set Poppins font for entered text
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10), // Add space between fields
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Add border radius
                ),
                labelStyle: TextStyle(fontFamily: 'Poppins'), // Set Poppins font
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_off), // Initially set to off
                  onPressed: () {}, // Add onPressed functionality
                ),
              ),
              obscureText: true,
              style: TextStyle(fontFamily: 'Poppins'), // Set Poppins font for entered text
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10), // Add space between fields
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Add border radius
                ),
                labelStyle: TextStyle(fontFamily: 'Poppins'), // Set Poppins font
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_off), // Initially set to off
                  onPressed: () {}, // Add onPressed functionality
                ),
              ),
              obscureText: true,
              style: TextStyle(fontFamily: 'Poppins'), // Set Poppins font for entered text
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Set button width to match parent
              child: ElevatedButton(
                onPressed: () {
                  // Define your register button action here
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF0C7230),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Increase font size
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
