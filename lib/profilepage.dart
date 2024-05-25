// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24.0,
                color: Color(0xFF0C7230),
                fontWeight: FontWeight.bold, // Bold added
              ),
            ),
            SizedBox(height: 20.0),
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Sample Name',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24.0, // Adjusted font size
                color: Color(0xFF0C7230),
                fontWeight: FontWeight.bold, // Bold added
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF0C7230),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold, // Bold added
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Contact Information:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '09123456789',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Additional Contact Information:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '09123456789',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Pickup Address:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '123 Barangay Sample Address St. Sample City',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add onPressed action here
              },
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text color added
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF0C7230),
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

