// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCA771A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'About',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0), // Consistent padding for entire PageView
        child: PageView(
          children: [
            buildImageContainer('images/farmers/about-cover.jpg'),
            buildImageContainer('images/farmers/vision-mission.jpg'),
            buildImageContainer('images/farmers/dev-goals.jpg'),
          ],
        ),
      ),
    );
  }

  Widget buildImageContainer(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Adjusted to give a softer appearance
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill, // Ensure image covers the entire container space
      ),
    );
  }
}
