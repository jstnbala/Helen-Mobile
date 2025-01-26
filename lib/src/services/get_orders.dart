import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // Import the logger package
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Logger logger = Logger();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<List<dynamic>?> getPendingOrders() async {
  // Retrieve the FullName and type from secure storage
  String? fullName = await secureStorage.read(key: 'FullName');
  String? userType = await secureStorage.read(key: 'UserType');

  // Check if the required data is available
  if (fullName == null || userType == null) {
    logger.e('FullName or UserType not found in secure storage.');
    return null; // Exit if any required information is missing
  }

  // Construct the API URL based on the user type, filtering out completed and received orders
  String queryParam = '';
  if (userType.toLowerCase() == 'farmer') {
    queryParam = 'FarmerName=$fullName&PendingOrder=true';
  } else if (userType.toLowerCase() == 'buyer') {
    queryParam = 'BuyerName=$fullName&PendingOrder=true';
  }

  final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/orders/?$queryParam');

  logger.i('Fetching orders with URL: $url'); // Log the URL being queried

  try {
    // Check SharedPreferences for cached orders
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedOrders = prefs.getString(pendingOrderCacheKey);
    int? cacheTimestamp = prefs.getInt(cacheTimestampKey);

    // Check if cached data is valid
    if (cachedOrders != null && cacheTimestamp != null) {
      final DateTime cacheDateTime = DateTime.fromMillisecondsSinceEpoch(cacheTimestamp);
      if (DateTime.now().difference(cacheDateTime) < cacheDuration) {
        // Return cached orders if still valid
        List<dynamic> orders = json.decode(cachedOrders);
        logger.i('Returning cached orders: $orders');
        return orders;
      } else {
        // Cache expired, remove old cache
        await prefs.remove(pendingOrderCacheKey);
        await prefs.remove(cacheTimestampKey);
        logger.i('Cache expired, fetching new orders.');
      }
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successfully retrieved orders
      List<dynamic> orders = json.decode(response.body);
      logger.i('Orders retrieved successfully: $orders');

      // Iterate over each order and get the ProductPic
      for (var order in orders) {
        String productName = order['ProductName'];
        String farmerName = order['FarmerName'];

        // Get the product pic for the respective order
        String? productPic = await getProductPic(productName, farmerName);

        order['productPic'] = productPic;
        if (productPic != null) {
          logger.i('Product Pic for ${order['OrderId']}: $productPic');
        } else {
          logger.w('No Product Pic found for ${order['OrderId']}.');
        }
      }

      // Save orders to shared preferences as PendingOrderCache
      await prefs.setString(pendingOrderCacheKey, json.encode(orders)); // Encode orders to JSON
      await prefs.setInt(cacheTimestampKey, DateTime.now().millisecondsSinceEpoch); // Store current timestamp

      return orders; // Return the list of orders with ProductPics added
    } else {
      logger.e('Failed to fetch orders. Status code: ${response.statusCode}');
      return null; // Indicate failure
    }
  } catch (e) {
    logger.e('Error fetching orders: $e'); // Log any errors
    return null; // Indicate failure
  }
}
