import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:helen_app/splash_screen.dart';
import 'package:helen_app/src/context/socket_context.dart'; 
import 'package:helen_app/src/services/notification_service.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  await NotificationService.requestPermission(); // Request permissionsFirebaseMessaging.getInstance().setAutoInitEnabled(true);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler); // Setup background messaging
  
 FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.i('Message received: ${message.messageId}');
    // Handle foreground messages here if needed
  });

  runApp(const MyApp());
}

// Background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();  // Ensure Firebase is initialized in background
  logger.i('Handling a background message: ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SocketProvider>(
          create: (_) => SocketProvider(), // Provide the SocketProvider
        ),
        // Add other providers here if necessary
      ],
      child: MaterialApp(
        title: 'HELEN',
        theme: ThemeData(
          primaryColor: const Color(0xFF4A5299),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,

      ),
    );
  }
}
