import 'dart:convert'; // Import to use jsonDecode
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class GetNotifications {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger();

  GetNotifications();

  Future<String?> getUserID() async {
    return await storage.read(key: 'id');
  }

  Future<List<dynamic>> getNotifications() async {
  final userId = await getUserID();

  if (userId == null) {
    throw Exception('User ID not found in secure storage');
  }
  final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/notifications/$userId');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response into a List<dynamic>
     
      return jsonDecode(response.body) as List<dynamic>;
    } else if (response.statusCode == 404) {
      // No notifications found, return an empty list
      logger.d('No notifications found for user');
      return [];
    } else {
      throw Exception('Failed to load notifications');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

  Future<int> getNotificationCount() async {
    
    final notifications = await getNotifications();
    return notifications.isNotEmpty ? notifications.length : 0; // Return count, 0 if empty
  }

  Future<bool> deleteNotifications(String id) async {
    final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/notifications/$id');

    try {
      final response = await http.delete(url);

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Optionally, you can decode the response body if needed
        final responseBody = jsonDecode(response.body);
        print('Notification deleted successfully: ${responseBody['message']}'); // Log success message
        return true; // Return true on successful deletion
      } else {
        // Handle error responses
        print('Failed to delete notification: ${response.statusCode}');
        return false; // Return false if deletion was not successful
      }
    } catch (e) {
      print('Error deleting notification: $e');
      return false; // Return false on error
    }
  }

}
