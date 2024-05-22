import 'package:flutter/material.dart';
import 'package:helen_app/getstarted.dart';
import 'package:helen_app/login.dart'; // Import the login.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HELEN',
      theme: ThemeData(
        primaryColor: Color(0xFF4A5299),
      ),
      home: GetStartedPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(), // Define the route
      },
    );
  }
}
