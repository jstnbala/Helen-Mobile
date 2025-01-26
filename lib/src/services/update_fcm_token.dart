import 'package:http/http.dart' as http;


Future<void> updateFcmTokenOnServer(String? fcmToken, String userType, String userId) async {
  // Implement your server call to update the FCM token
  print('fcmtoken in update: $fcmToken');
  print('UserType: $userType');

  try {
    final response = await http.post(
      Uri.parse('https://helen-server-lmp4.onrender.com/api/notifications/updatefcm/$userId?UserType=$userType'),
      body: {
        'FCM_Token': fcmToken, // Ensure you pass the token correctly
      },                                                        
    );

    if (response.statusCode == 200) {
      print('FCM Token successfully updated on the server');
    } else {
      print('Failed to update FCM Token on server. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error updating FCM Token on server: $e');
  }
}