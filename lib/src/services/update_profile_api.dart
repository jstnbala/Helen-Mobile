import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const FlutterSecureStorage storage = FlutterSecureStorage();

Future<void> updateProfilePicture(String imagePath) async {
  final encodedOrganization = Uri.encodeComponent(await storage.read(key: 'Organization') ?? '');
  final id = await storage.read(key: 'id');

  final url = 'https://helen-server-lmp4.onrender.com/api/organizations/$encodedOrganization/farmers/$id';

  try {
    final request = http.MultipartRequest('PUT', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('ProfilePicture', imagePath));
    final response = await request.send();

    if (response.statusCode == 200) {
      print('Profile picture updated successfully');
      await storage.write(key: 'ProfilePicture', value: imagePath);
    } else {
      print('Failed to update profile picture: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('An error occurred while updating profile picture: $e');
  }
}