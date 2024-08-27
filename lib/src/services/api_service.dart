// ignore_for_file: avoid_print, prefer_const_declarations, non_constant_identifier_names

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Farmer Side

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

// Dropdown Registration Farmer Organization

Future<List<String>> fetchOrganizations() async {
  try {
    final response = await http.get(Uri.parse('https://helen-project.onrender.com/api/organizations'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<String> organizations = data
        .map<String>((org) => org['OrgName']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();

      return organizations;
    } else {
      throw Exception('Failed to load organizations');
    }
  } catch (e) {
    print('Failed to fetch organizations: $e');
    return [];
  }
}

// Upcoming Events

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
  final storage = const FlutterSecureStorage();
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

Future<bool> addProduct({
  required String productName,
  required String farmerName,
  required String price,
  required String unit,
  required String inventory,
  required File productPic,
  required String productDetails,

}) async {
  final storage = const FlutterSecureStorage();
  final orgname = await storage.read(key: 'Organization');
  print("price: $price");

  if (orgname == null) {
    print('Organization name is missing');
    return false;
  }

  // Construct the URL
  final url =  Uri.parse('https://helen-project.onrender.com/api/organizations/$orgname/products');

  final dateAdded = DateTime.now().toString();
  int? number = int.tryParse(inventory);
  double? convertedPrice = double.tryParse(price);

  // Create a MultipartRequest
  var request = http.MultipartRequest('POST', url);
 
  // Add text fields
  request.fields['DateAdded'] = dateAdded;
  request.fields['ProductName'] = productName;
  request.fields['FarmerName'] = farmerName;
  request.fields['Price'] = convertedPrice.toString();
  request.fields['Unit'] = unit;
  request.fields['status'] = 'Pending';
  request.fields['Inventory'] = number.toString();
  request.fields['ProductDetails'] = productDetails;

  // Add the image file
  request.files.add(await http.MultipartFile.fromPath('ProductPic', productPic.path));

  // Send the request
  try {
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 201) { // Assuming 201 Created is the success status
      print('Product added successfully');
      return true;
    } else {
      print('Failed to add product: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('An error occurred: $e');
    return false;
  }
}

// Buyer Side

Future<bool> registerBuyer({
  required String username,
  required String fullName,
  required String address,
  required String contactNo,
  required String accountType,
  required String password,
}) async {
  const url = 'https://helen-project.onrender.com/api/buyers';

  final payload = {
    'Username': username,
    'FullName': fullName,
    'Address': address,
    'Contact': contactNo,
    'AccountType': accountType,
    'Password': password,
    'status': 'Registered',
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) { // Updated to check for 200 OK
      print('Buyer registration successful');
      return true;
    } else if (response.statusCode == 409) {
      print('Buyer registration failed: Username already exists');
      return false;
    } else {
      print('Buyer registration failed: ${response.statusCode}, ${response.body}');
      return false;
    }
  } catch (e) {
    print('An error occurred: $e');
    return false;
  }
}

// Login Farmer and Buyer 

Future<bool> login({
  required String username,
  required String password,
}) async {
  const url = 'https://helen-project.onrender.com/api/auth/user-login';

  final payload = {
    'Username': username,
    'Password': password,
  }; 

  final storage = const FlutterSecureStorage();

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

        await storage.write(key: 'UserType', value: responseData["UserType"]);
        await storage.write(key: 'id', value: responseData['_id']);

        if(responseData['UserType'] == 'farmer') {

        await storage.write(key: 'ProfilePicture', value: responseData['ProfilePicture']);
        await storage.write(key: 'Username', value: responseData["Username"]);
        await storage.write(key: 'Password', value: responseData["Password"]);
        await storage.write(key: 'FullName', value: responseData["FullName"]);
        await storage.write(key: 'RSBSA_No', value: responseData["RSBSA_No"]);
        await storage.write(key: 'Contact', value: responseData["Contact"]);
        await storage.write(key: 'Address', value: responseData["Address"]);
        await storage.write(key: 'Organization', value: responseData["Organization"]);
        await storage.write(key: 'status', value: responseData["status"]);

        } else if (responseData['UserType'] == 'buyer') {

        await storage.write(key: 'ProfilePicture', value: responseData['ProfilePicture']);
        await storage.write(key: 'Username', value: responseData["Username"]);
        await storage.write(key: 'Password', value: responseData["Password"]); 
        await storage.write(key: 'FullName', value: responseData["FullName"]);
        await storage.write(key: 'Contact', value: responseData["Contact"]);
        await storage.write(key: 'Address', value: responseData["Address"]);
        await storage.write(key: 'AccountType', value: responseData["AccountType"]);
        await storage.write(key: 'status', value: responseData["status"]);
        }
        
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
