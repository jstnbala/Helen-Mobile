import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class NotificationService {
  static final Logger logger = Logger();
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

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

      if (token != null) {
        // Save the token in secure storage
        await secureStorage.write(key: 'FCM_Token', value: token);
        logger.i("Token saved in secure storage");
      } else {
        logger.w("FCM Token is null");
      }
    } catch (e) {
      logger.e("Error getting FCM token: $e");
    }
  }

  static Future<String?> getTokenFromStorage() async {
    // Retrieve the token from secure storage
    return await secureStorage.read(key: 'FCM_Token');
  }
}
