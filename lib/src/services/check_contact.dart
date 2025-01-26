// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:helen_app/src/services/fetch_org_api.dart';
import 'package:http/http.dart' as http;


 Future<List<String>> checkContactsAndUsername() async {
    final organizations = FetchOrgApi.fetchAllOrganizations();


    final farmerUrl = 'https://helen-server-lmp4.onrender.com/api/organizations/$organizations/farmers';
    final buyerUrl =  'https://helen-server-lmp4.onrender.com/api/buyers/';

    try {
      final response = await http.get(Uri.parse(buyerUrl), headers: {
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



