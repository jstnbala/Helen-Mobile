import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class GetOrgProductsAPI {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger(); // Create an instance of Logger

  GetOrgProductsAPI();

  Future<List<Map<String, dynamic>>?> getOrgProducts(String organization) async {
    try {
      final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/organizations');

      // Send the GET request
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> data = json.decode(response.body);

        // Filter the organization by its name
        final orgData = data.firstWhere(
          (org) => org['OrgName'] == organization,
          orElse: () => null,
        );

        if (orgData != null) {
          // Retrieve the products array from the organization data
          List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(orgData['products']);

          // Log each product in the array using the logger
          for (var product in products) {
            logger.i(product); // Info log for each product map
          }

          // Return the products array if the organization is found
          return products;
        } else {
          // Organization not found
          logger.w('Organization not found'); // Warning log
          return null;
        }
      } else {
        // Handle error response
        logger.e('Failed to fetch organizations'); // Error log
        return null;
      }
    } catch (e) {
      logger.e('Error occurred: $e'); // Error log for exceptions
      return null;
    }
  }
}
