import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:helen_app/splash_screen.dart';
import 'package:helen_app/src/context/socket_context.dart';
import 'package:helen_app/src/services/notification_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helen_app/src/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

final Logger logger = Logger();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  await requestStoragePermission(); // Request storage permission
  await NotificationService.requestPermission(); // Request notification permissions
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler); // Setup background messaging

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.i('Message received: ${message.messageId}');
    // Handle foreground messages and show notification
    _showNotification(message);
  });

  runApp(const MyApp());
}

Future<void> requestStoragePermission() async {
  AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;

  if (build.version.sdkInt >= 30) {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  } else {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
}


// Background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();  // Ensure Firebase is initialized in background
  logger.i('Handling a background message: ${message.messageId}');
}

// Function to show notification
Future<void> _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    NotificationConstants.channelId, // Use the constant for Channel ID
    NotificationConstants.channelName, // Use the constant for Channel Name
    channelDescription: NotificationConstants.channelDescription,
    importance: Importance.high,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    message.hashCode, // Notification ID
    message.notification?.title, // Notification title
    message.notification?.body, // Notification body
    platformChannelSpecifics,
    payload: message.data['payload'], // Optional, can be used for navigation
  );
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
