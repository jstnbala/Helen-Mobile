import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:helen_app/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    );
  }
}
