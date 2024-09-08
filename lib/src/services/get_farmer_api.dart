import 'dart:convert';
import 'package:helen_app/src/services/fetch_org_api.dart'; // Import FetchOrgApi from your services
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetFarmerApi {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  GetFarmerApi();

  Future<Map<String, dynamic>?> getFarmer(String farmerName) async {
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

          // Find the first farmer with the matching name
          var matchingFarmer = farmers.firstWhere(
            (farmer) => farmer['FullName'].toLowerCase() == farmerName.toLowerCase(),
            orElse: () => null,
          );

          // If a matching farmer is found, return the farmer
          if (matchingFarmer != null) {
            return matchingFarmer;
          }
        } else {
          throw Exception('Failed to load farmers for organization: $org');
        }
      } catch (e) {
        throw Exception('Error fetching farmers for organization $org: $e');
      }
    }

    // Return null if no farmer is found
    return null;
  }
}
