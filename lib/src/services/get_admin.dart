import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> getAdminForSupport(List<String> ids, String role) async {
  // Construct the URL for the POST request
  final url = 'https://helen-server-lmp4.onrender.com/api/admin/support';
  print('ids: ' + jsonEncode(ids));
  try {
    // Create the request body with the provided IDs and Role
    final body = json.encode({'ids': ids, 'role': role}); // Sending a list of IDs

    // Perform the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json', // Specify the content type
      },
      body: body, // Sending the request body
    );

    // Check the response status
    if (response.statusCode == 200) {
      // Parse the response body
      final Map<String, dynamic> data = json.decode(response.body);

      // Return the admin object or null if not found
      return data.isNotEmpty ? data : null; // Return admin data if found
    } else {
      // Log error and return null on failure
      print('Failed to find admin: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('An error occurred while fetching the admin: $e');
    return null; // Return null on catch
  }
}
