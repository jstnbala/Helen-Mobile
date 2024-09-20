import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class NotificationService {
  static final Logger logger = Logger();

  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.i('User granted permission');
      _getToken(); // Get FCM token after permission is granted
    } else {
      logger.w('User declined or has not accepted permission');
    }
  }

  static Future<void> _getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      logger.i("FCM Token: $token");

      // Send the token to your server or store it for later use
      // e.g., save to secure storage, send to backend
    } catch (e) {
      logger.e("Error getting FCM token: $e");
    }
  }
}
