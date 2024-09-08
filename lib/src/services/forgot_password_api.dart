import 'dart:convert';
import 'package:helen_app/src/services/fetch_org_api.dart'; // Import FetchOrgApi from your services
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UpdatePasswordApi {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  UpdatePasswordApi ();
  
  Future<Map<String, dynamic>?> getAccount(String phoneNumber) async {
    // Fetch all organizations
    final List<String> organizations = await FetchOrgApi.fetchAllOrganizations();

    // Loop through each organization and fetch its farmers
    for (var org in organizations) {
      final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/organizations/$org/farmers');

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          // Parse the response body
          List<dynamic> farmers = jsonDecode(response.body);

          // Find the first farmer with the matching phone number
          var matchingFarmer = farmers.firstWhere(
            (farmer) => farmer['Contact'].toLowerCase() == phoneNumber.toLowerCase(),
            orElse: () => null,
          );

          // If a matching farmer is found, return the farmer with type "farmer"
          if (matchingFarmer != null) {
            return {
              'type': 'farmer',
              'id': matchingFarmer['_id'],
            };
          }
        } else {
          throw Exception('Failed to load farmers for organization: $org');
        }
      } catch (e) {
        throw Exception('Error fetching farmers for organization $org: $e');
      }
    }

    // If no matching farmer is found, check the buyers API
    try {
      final buyersUrl = Uri.parse('https://helen-server-lmp4.onrender.com/api/buyers');
      final buyersResponse = await http.get(buyersUrl);

      if (buyersResponse.statusCode == 200) {
        List<dynamic> buyers = jsonDecode(buyersResponse.body);

        // Find the first buyer with the matching phone number
        var matchingBuyer = buyers.firstWhere(
          (buyer) => buyer['Contact'].toLowerCase() == phoneNumber.toLowerCase(),
          orElse: () => null,
        );

        // If a matching buyer is found, return the buyer with type "buyer"
        if (matchingBuyer != null) {
          return {
            'type': 'buyer',
            'id': matchingBuyer['_id'],
          };
        }
      } else {
        throw Exception('Failed to load buyers');
      }
    } catch (e) {
      throw Exception('Error fetching buyers: $e');
    }

    // If no matching farmer or buyer is found, return null
    return null;
  }


  Future<bool> updatePassword({
    required String newPassword,
    required String userId,
    required String type,
  }) async {
    // Fetch all organizations
    final List<String> organizations = await FetchOrgApi.fetchAllOrganizations();

    if (type == 'farmer') {
      // Loop through each organization and update the farmer's password
      for (var org in organizations) {
        final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/organizations/$org/farmers/$userId');

        try {
          final response = await http.put(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'Password': newPassword,
            }),
          );

          if (response.statusCode == 200) {
            // Return true if the password was updated successfully
            return true;
          } else {
            // Return false if the update failed
            return false;
          }
        } catch (e) {
          // Return false if there was an error
          return false;
        }
      }
    } else if (type == 'buyer') {
      // Update the buyer's password
      final buyersUrl = Uri.parse('https://helen-server-lmp4.onrender.com/api/buyers/$userId');

      try {
        final response = await http.put(
          buyersUrl,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'Password': newPassword,
          }),
        );

        if (response.statusCode == 200) {
          // Return true if the password was updated successfully
          return true;
        } else {
          // Return false if the update failed
          return false;
        }
      } catch (e) {
        // Return false if there was an error
        return false;
      }
    } else {
      // Return false if the type is invalid
      return false;
    }

    // Return false if no update was performed
    return false;
  }


}
