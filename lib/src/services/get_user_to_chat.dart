import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // For logging
import 'fetch_org_api.dart';

class GetUserToChatService {
  final Logger _logger = Logger();

  Future<Map<String, String>> getUserToChatDetailsById(String usertoChatId) async {
    _logger.i('Attempting to get userToChat from admin...');
    
    // Fetch from admin API first
    final adminResponse = await http.get(Uri.parse('https://helen-server-lmp4.onrender.com/api/admin/$usertoChatId'));
    
    if (adminResponse.statusCode == 200) {
      final data = json.decode(adminResponse.body);
      _logger.i('User found in admin: ${data['FullName']}');
      return {
        'FullName': data['FullName'],
        'ProfilePicture': data['ProfilePicture'],
      };
    } else if (adminResponse.statusCode == 404) {
      _logger.w('User not found in admin, checking farmers...');
      
      // Fetch organizations and check in each organization's farmers API
      List<String> organizations = await FetchOrgApi.fetchAllOrganizations();
      
      for (String organization in organizations) {
        _logger.i('Checking organization: $organization');
        final farmerResponse = await http.get(Uri.parse('https://helen-server-lmp4.onrender.com/api/organizations/$organization/farmers/$usertoChatId'));
        
        if (farmerResponse.statusCode == 200) {
          final data = json.decode(farmerResponse.body);
          _logger.i('User found in farmers of $organization: ${data['FullName']}');
          return {
            'FullName': data['FullName'],
            'ProfilePicture': data['ProfilePicture'],
          };
        } 
      }
      
      // If user not found in farmers, check buyers
      _logger.w('User not found in any farmers, checking buyers...');
      final buyerResponse = await http.get(Uri.parse('https://helen-server-lmp4.onrender.com/api/buyers/$usertoChatId'));
      
      if (buyerResponse.statusCode == 200) {
        final data = json.decode(buyerResponse.body);
        _logger.i('User found in buyers: ${data['FullName']}');
        _logger.i('ProfilePicture ${data['ProfilePicture']}');
        return {
          'FullName': data['FullName'],
          'ProfilePicture': data['ProfilePicture'] ?? '',
        };
      } else if (buyerResponse.statusCode == 404) {
        _logger.e('User not found in admin, farmers, or buyers');
        throw Exception('User not found in admin, farmers, or buyers');
      }
    }
    
    _logger.e('Failed to load user');
    throw Exception('Failed to load user');
  }
}