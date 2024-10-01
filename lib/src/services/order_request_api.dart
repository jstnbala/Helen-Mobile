import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Initialize Logger
final logger = Logger();
const storage = FlutterSecureStorage();

Future<List<dynamic>> fetchRequests() async {
  try {
    // Retrieve FullName from secure storage
    String? fullName = await storage.read(key: 'FullName');
    
    if (fullName == null) {
      logger.e('FullName not found in secure storage.');
      return []; // Return an empty list if FullName is not found
    }

   
    // Check if data is stored in Shared Preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('cachedRequests');
    int? cacheTimestamp = prefs.getInt('cacheTimestamp');

    // Check if cached data is available and valid
    if (cachedData != null && cacheTimestamp != null) {
      // If the cache is less than 5 minutes old, return cached data
      if (DateTime.now().millisecondsSinceEpoch - cacheTimestamp < Duration(minutes: 5).inMilliseconds) {
        logger.i('Using cached data.');
        // Parse the cached data and return it
        return jsonDecode(cachedData);
      }
    }

    // Construct the URL with the BuyerName as a query parameter
    final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/requests?BuyerName=$fullName');

    // Log the request URL and BuyerName
    logger.i('Fetching requests for BuyerName: $fullName');
    logger.d('Request URL: $url');

    // Make the GET request
    final response = await http.get(url);

    // Log the status code
    logger.i('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Parse the response JSON
      final List<dynamic> data = jsonDecode(response.body);
 // Store the fetched data in Shared Preferences
      await prefs.setString('cachedRequests', response.body);
      await prefs.setInt('cacheTimestamp', DateTime.now().millisecondsSinceEpoch); // Update the cache timestamp  
          // Log the successful response
      logger.i('Fetched requests successfully.');
      logger.d('Response data: $data');

      // Return the dynamic list of requests
      return data;
    } else {
      // Log an error if the response status code is not 200
      logger.e('Failed to load requests. Status code: ${response.statusCode}');
      return []; // Return an empty list in case of failure
    }
  } catch (e) {
    // Log any exception that occurs
    logger.e('Error fetching requests: $e');
    return []; // Return an empty list in case of error
  }
}

Future<List<dynamic>> fetchRequestsForPayment() async {
  try {
    // Retrieve FullName from secure storage
    String? fullName = await storage.read(key: 'FullName');
    
    if (fullName == null) {
      logger.e('FullName not found in secure storage.');
      return []; // Return an empty list if FullName is not found
    }

   
    // Check if data is stored in Shared Preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('cachedRequestsForPayment');
    int? cacheTimestamp = prefs.getInt('cacheTimestamp');

    // Check if cached data is available and valid
    if (cachedData != null && cacheTimestamp != null) {
      // If the cache is less than 5 minutes old, return cached data
      if (DateTime.now().millisecondsSinceEpoch - cacheTimestamp < Duration(minutes: 5).inMilliseconds) {
        logger.i('Using cached data.');
        // Parse the cached data and return it
        return jsonDecode(cachedData);
      }
    }

    // Construct the URL with the BuyerName as a query parameter
    final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/requests-ForPayment?BuyerName=$fullName');

    // Log the request URL and BuyerName
    logger.i('Fetching requests for BuyerName: $fullName');
    logger.d('Request URL: $url');

    // Make the GET request
    final response = await http.get(url);

    // Log the status code
    logger.i('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Parse the response JSON
      final List<dynamic> data = jsonDecode(response.body);
 // Store the fetched data in Shared Preferences
      await prefs.setString('cachedRequestsForPayment', response.body);
      await prefs.setInt('cacheTimestamp', DateTime.now().millisecondsSinceEpoch); // Update the cache timestamp  
          // Log the successful response
      logger.i('Fetched requests successfully.');
      logger.d('Response data: $data');

      // Return the dynamic list of requests
      return data;
    } else {
      // Log an error if the response status code is not 200
      logger.e('Failed to load requests. Status code: ${response.statusCode}');
      return []; // Return an empty list in case of failure
    }
  } catch (e) {
    // Log any exception that occurs
    logger.e('Error fetching requests: $e');
    return []; // Return an empty list in case of error
  }
}

