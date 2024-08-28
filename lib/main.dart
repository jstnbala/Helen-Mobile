import 'package:flutter/material.dart';
import 'package:helen_app/account_type.dart';
import 'package:helen_app/splash_screen.dart';
import 'package:helen_app/src/views/common/login.dart';

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
        primaryColor: const Color(0xFF4A5299),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/account-type': (context) => const AccountTypeScreen(), // Define the route
        ' /login': (context) => const LoginPage(), // Assuming you have a LoginScreen defined
      },
    );
  }
}
