import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> registerFarmer({
  required String username,
  required String fullName,
  required String address,
  required String organization,
  required String contactNo,
  required String rsbsaNo,
  required String password,
}) async {
  // Construct the URL with the organization variable
  final encodedOrganization = Uri.encodeComponent(organization);
  final url = 'https://helen-project.onrender.com/api/organizations/$encodedOrganization/farmers';


  final dateRegistered = DateTime.now().toIso8601String();
  // Create the payload
  final payload = {
    'DateRegistered': dateRegistered,
    'Username': username,
    'FullName': fullName,
    'Address': address,
    'Organization': organization, 
    'Contact': contactNo,
    'RSBSA_No': rsbsaNo,
    'Password': password,
    'status': 'Registered',
  };

  // Make the POST request
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    // Check the response status
    if (response.statusCode == 201) { // Assuming 201 Created is the success status
      print('Registration successful');
      return true;
    } else {
      print('Registration failed: ${response.body}');
      return false;
    }
  } catch (e) {
    print('An error occurred: $e');
    return false;
  }
}

Future<bool> loginFarmer({
  required String username,
  required String password,
}) async {
  const url = 'https://helen-project.onrender.com/api/auth/user-login';

  print('username: $username');
  print('password: $password');

  final payload = {
    'Username': username,
    'Password': password,
  };

print('payload: $payload');
  final storage = FlutterSecureStorage();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Assuming the response is a JSON object with a `success` key
      if (responseData['success'] == true) {
        print('Login successful');

        await storage.write(key: 'ProfilePicture', value: responseData['ProfilePicture']);
        await storage.write(key: 'Username', value: responseData["Username"]);
        await storage.write(key: 'Password', value: responseData["Password"]);
        await storage.write(key: 'FullName', value: responseData["FullName"]);
        await storage.write(key: 'Contact', value: responseData["Contact"]);
        await storage.write(key: 'Address', value: responseData["Address"]);
        await storage.write(key: 'Organization', value: responseData["Organization"]);
        await storage.write(key: 'DateRegistered', value: responseData["DateRegistered"]);
        await storage.write(key: 'status', value: responseData["status"]);

        return true;
      } else {
        print('Login failed: ${responseData['message'] ?? 'Unknown error'}');
        return false;
      }
    } else {
      print('Failed to authenticate: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('An error occurred: $e');
    return false;
  }
}

class Event {
  final String startDate;
  final String endDate;
  final String title;
  final String description;
  final String organization;
  final String location;
  final String time;
  final String photo;
  final String status;

  Event({
    required this.startDate,
    required this.endDate,
    required this.title,
    required this.description,
    required this.organization,
    required this.location,
    required this.time,
    required this.photo,
    required this.status,
  });

  // Factory method to create an Event object from JSON
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      startDate: json['startDate'],
      endDate: json['endDate'],
      title: json['title'],
      description: json['description'],
      organization: json['Organization'],
      location: json['location'],
      time: json['time'],
      photo: json['Photo'],
      status: json['status'],
    );
  }
}

Future<List<Event>> fetchUpcomingEvents() async {
  final storage = FlutterSecureStorage();
  final OrgName = await storage.read(key: 'Organization');

  if (OrgName == null) {
    print('Organization name is missing');
    return [];
  }

  final url = 'https://helen-project.onrender.com/api/organizations/$OrgName/events';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      List<Event> events = responseData.map((eventJson) => Event.fromJson(eventJson)).toList();

      print('Events fetched successfully');
      return events;
    } else {
      print('Failed to fetch events: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('An error occurred: $e');
    return [];
  }
}

