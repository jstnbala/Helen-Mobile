// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to LoginPage after 5 seconds
    Timer(const Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCA771A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/splashlogo.png',
              width: 200, // adjust the width as needed
              height: 200, // adjust the height as needed
            ),
            const SizedBox(height: 20), // space between image and text
            const Text(
              'Harnessing, Expanding, Livelihood, Enterprise, Network',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18, // adjust the size as needed
                color: Colors.white,
                height: 1.2, // line spacing adjustment
              ),
            ),
            const SizedBox(height: 20), // space between text and loading bar
            SizedBox(
              width: 250, // adjust the width of the loading bar
              child: LinearProgressIndicator(
                backgroundColor: Colors.white.withOpacity(0.5),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 8, // adjust the height of the loading bar
              ),
            ),
          ],
        ),
      ),
    );
  }
}
