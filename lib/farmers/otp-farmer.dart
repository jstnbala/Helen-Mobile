// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class OTPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of focus nodes for each text field
    final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCA771A),
        title: Text(
          'OTP',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'We have sent the verification code \nthrough SMS. Please check your \nmessages and enter the code.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF606060),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                '+63 **** *** 3744',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF606060),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFCA771A)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: TextField(
                        focusNode: focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF606060),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {
                  // Handle confirm action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFCA771A),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Didn't receive code?",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF606060),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Handle resend OTP action
                },
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCA771A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20), // Add some spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}