// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchOrgApi {
  static Future<List<String>> fetchAllOrganizations() async {
    const url = 'https://helen-server-lmp4.onrender.com/api/organizations';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map<String>((org) => org['OrgName'] as String).toList();
      } else {
        throw Exception('Failed to load organizations');
      }
    } catch (e) {
      print('An error occurred while fetching organizations: $e');
      return [];
    }
  }
}


