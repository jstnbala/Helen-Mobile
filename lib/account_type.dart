// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/registration-buyer.dart';
import 'package:helen_app/src/views/screens/farmers/registration_module/registration-farmer.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCA771A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Select Account Type',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200, // Adjusted height to ensure it fits on smaller screens
                  child: Image.asset(
                    'images/are-you-a-farmer.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCA771A),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16), // Adjusted padding for better fit
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FarmerRegistrationPage()),
                    );
                  },
                  child: Text(
                    'Are you a Farmer?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 200, // Adjusted height to ensure it fits on smaller screens
                  child: Image.asset(
                    'images/are-you-a-buyer.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCA771A),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16), // Adjusted padding for better fit
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BuyerRegistrationPage()),
                    );
                  },
                  child: Text(
                    'Are you a Buyer?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
