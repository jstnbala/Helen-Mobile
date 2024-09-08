import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetConversationsApi {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  GetConversationsApi();

  Future<String?> getUserID() async {
    return await storage.read(key: 'id');
  }

  Future<List<dynamic>> getMessages() async {
    final userId = await getUserID();
    if (userId == null) {
      throw Exception('User ID not found in secure storage');
    }

    final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/conversations/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> conversations = jsonDecode(response.body);
        return conversations;
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
