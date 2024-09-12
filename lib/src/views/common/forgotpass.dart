// ignore_for_file:, library_private_types_in_public_api,, unused_import
import 'package:flutter/material.dart';
 
class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});
 
  @override
  // ignore: library_private_types_in_public_api
  _ForgotPassPageState createState() => _ForgotPassPageState();
}
 
class _ForgotPassPageState extends State<ForgotPassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFCA771A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Placeholder to balance the center text
                ],
              ),
            ),
            const SizedBox(height: 40),
 
            // Forgot Password Icon
            const Icon(
              Icons.person_outline,
              size: 100,
              color: Color(0xFFCA771A),
            ),
            const SizedBox(height: 20),
 
            // Info Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Please enter your username and contact number to change your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),
 
            // Username Field
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFFCA771A), width: 2.0),
                   ),
                ),
              ),
            ),
            const SizedBox(height: 20),
 
            // Contact Number Field
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Contact No',
                  hintText: 'Enter your contact number',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFFCA771A), width: 2.0),
                   ),
                ),
              ),
            ),
            const SizedBox(height: 30),
 
            // Change Password Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA771A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                 
                },
                child: const Center(
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Added bottom spacing
          ],
        ),
      ),
    );
  }
}
 
 