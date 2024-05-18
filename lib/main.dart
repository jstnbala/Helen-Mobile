import 'package:flutter/material.dart';
import 'package:helen_app/getstarted.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HELEN',
      theme: ThemeData(primaryColor: Color(0xFF4A5299),
      ),
      home: GetStartedPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}