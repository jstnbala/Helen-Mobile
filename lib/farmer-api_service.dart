import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode
import 'package:bcrypt/bcrypt.dart'; // For bcrypt hashing

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



Future<List<String>> fetchOrganizations() async {
  final url = 'https://helen-project.onrender.com/api/organizations';
  
  try {
    final response = await http.get(Uri.parse(url));
    print("fetching org");
    
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print("response org ok");
      // Assuming the response is a list of organization names
      if (responseData is List) {
        
        return responseData.map<String>((org) => org['OrgName'].toString()).toList();
      } else {
        print('Unexpected response format');
        return [];
      }
    } else {
      print('Failed to fetch organizations: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('An error occurred: $e');
    return [];
  }
}




Future<bool> loginFarmer({
  
  required String username,
  required String password,
}) async {
  final organizations = await fetchOrganizations();

  for (var organization in organizations) {
    final encodedOrganization = Uri.encodeComponent(organization);
    final url = 'https://helen-project.onrender.com/api/organizations/$encodedOrganization/farmers';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData is List) {
          for (var farmer in responseData) {
            // Assuming `farmer['Password']` is the hashed password
            final storedHash = farmer['Password'];
            final isPasswordValid = BCrypt.checkpw(password, storedHash);

            print('isPasswordSame: $isPasswordValid');

            if (farmer['Username'] == username && isPasswordValid) {
              print('Login successful for organization: $organization');
              return true;
            }
          }
        } else {
          print('Unexpected response format for organization: $organization');
        }
      } else {
        print('Failed to fetch farmers for organization $organization: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching farmers for organization $organization: $e');
    }
  }
  return false;
}
