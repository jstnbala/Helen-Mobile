import 'package:flutter/material.dart';

class ProfileInsti extends StatelessWidget {
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
                child: Icon(
                  Icons.person,
                  size: 100.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Jollibee',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28.0,
                  color: Color(0xFFCA771A),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '@jollibee_candelaria',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFFCA771A), // Adjust color as needed
                    size: 24.0,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Stack(
                children: [
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
                          'Buyer Information',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Full Name / Business Name:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Jollibee Lucena Corporation',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Address:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '28 Magdayao Candelaria Quezon Province',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Contact No:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '09278557033',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
