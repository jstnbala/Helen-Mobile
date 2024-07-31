// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.grey,
                child: ClipOval(
                  child: Image.asset(
                    'images/farmers/farmer-profile.png',
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nestor Matimatico',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24.0,
                      color: Color(0xFFCA771A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center, // Ensure vertical alignment
                    children: [
                      Text(
                        '@akosiNestor',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                      SizedBox(width: 10.0), // Adjust spacing if needed
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFFCA771A),
                        size: 24.0,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFCA771A),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Farmer Information',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Full Name:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Nestor Matimatico',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '28 Candelaria Street Lucban',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Organization:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Lucban Agricultural Cooperative Society',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Accreditation Level:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Provincial',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Contact No:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '09278557033',
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
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFCA771A),
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
