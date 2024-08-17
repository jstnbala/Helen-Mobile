import 'package:flutter/material.dart';

class SpecificEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCA771A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Specific Event',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
          children: [
            Center(
              child: Container(
                height: 200.0,
                width: 350.0,  // Increase the width of the image container
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFCA771A),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Icon(
                  Icons.image_not_supported,
                  size: 150.0,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Title of the Event',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCA771A),
              ),
              textAlign: TextAlign.center, // Center the text within its container
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Start Date',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
             SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'End Date',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Time',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Location',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              textAlign: TextAlign.left, // Align the text to the left
            ),
          ],
        ),
      ),
    );
  }
}
