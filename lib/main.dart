import 'package:flutter/material.dart';
import 'package:helen_app/account-type.dart';
import 'package:helen_app/farmers/login.dart';

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
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/account-type': (context) => AccountTypeScreen(), // Define the route
        '/login': (context) => LoginPage(), // Assuming you have a LoginScreen defined
      },
    );
  }
}
