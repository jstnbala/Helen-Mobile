import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetMessagesApi {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  GetMessagesApi();

  Future<String?> getUserID() async {
    return await storage.read(key: 'id');
  }

  Future<List<dynamic>> getMessages(String userToChatId) async {
    final userId = await getUserID(); // Retrieve userId from storage
    if (userId == null) {
      throw Exception('User ID not found in storage');
    }

    final response = await http.get(Uri.parse('https://helen-server-lmp4.onrender.com/api/conversations/messages/$userToChatId/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return the list of messages
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<Map<String, dynamic>?>sendMessages(String receiverId, String message) async {
    final userId = await getUserID(); // Retrieve userId from storage
    if (userId == null) {
      throw Exception('User ID not found in storage');
    }

    final response = await http.post(
      Uri.parse('https://helen-server-lmp4.onrender.com/api/conversations/messages/send/$receiverId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'senderId': userId,
        'message': message,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body); // Return the list of messages
    } else {
      throw Exception('Failed to send message');
    }
  }
}
