// ignore_for_file: avoid_print, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:helen_app/src/services/update_profile_api.dart';

import 'package:helen_app/src/widgets/profile_widgets.dart';
import 'package:helen_app/src/widgets/name_widgets.dart'; 
import 'package:helen_app/src/widgets/serviceinfo_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final ImagePicker _picker = ImagePicker();
  Map<String, String?> userDetails = {};
  String userType = 'buyer'; // Default user type

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<String> getUserType() async {
  // Fetch the user type from secure storage
    final userType = await storage.read(key: 'UserType');
    return userType ?? 'buyer'; // Replace 'default' with the key for other user types if needed
  }

  Future<Map<String, String?>> getUserDetails() async {
    final userType = await getUserType();

    // Define keys based on user type
    final Map<String, List<String>> userKeys = {
      'farmer': [
        'ProfilePicture', 'FullName', 'Username', 'RSBSA_No', 'Address', 'Contact', 'Organization',
      ],
      // Define other user types and their keys
      'buyer': [
        'ProfilePicture', 'FullName', 'Username','Address', 'Contact', 'AccountType'// example for other user types
      ],
    };

    // Get keys for the current user type
    final keys = userKeys[userType] ?? [];

    final Map<String, String?> details = {};

    for (var key in keys) {
      details[key] = await storage.read(key: key);
      print("$key: ${details[key]}");
    }

    return details;
  }

  Future<void> _loadUserDetails() async {
    userDetails = await getUserDetails();
    userType = await getUserType();
    setState(() {});
  }

  List<Map<String, dynamic>> _getDetailConfigs() {
    final detailConfigs = {
      'farmer': [
        {'title': 'Full Name:', 'key': 'FullName', 'icon': Icons.person},
        {'title': 'Address:', 'key': 'Address', 'icon': Icons.location_on},
        {'title': 'Contact No:', 'key': 'Contact', 'icon': Icons.phone},
        {'title': 'RSBSA No:', 'key': 'RSBSA_No', 'icon': Icons.phone},
        {'title': 'Organization:', 'key': 'Organization', 'icon': Icons.business},
      ],
      'buyer': [
        {'title': 'Full Name:', 'key': 'FullName', 'icon': Icons.person},
        {'title': 'Address:', 'key': 'Address', 'icon': Icons.location_on},
        {'title': 'Contact No:', 'key': 'Contact', 'icon': Icons.phone},
        {'title': 'Account Type:', 'key': 'AccountType', 'icon': Icons.account_circle},
      ],
    };

    return detailConfigs[userType] ?? [];
  }

  Future<void> _pickImage(ImageSource source) async {

    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      await updateProfilePicture(image.path); // Use the imported function
      setState(() {}); // Ensure the UI updates if needed
    }
  }
  
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose an option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Upload from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildDetail(String title, String key, IconData icon) {
    return FutureBuilder<String?> (
      future: getUserDetails().then((details) => details[key]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10.0),
               Expanded( // Ensures text has space to grow if needed
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              )
            ],
          );
        } else {
          return Column(
            
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [     
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w600 ,
              ),
            ),
             const SizedBox(width: 8.0),
            Row(
              children: [
               
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  snapshot.data!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
               
              ],
            ),
          ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const ProfilePictureWidget(),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _showImagePickerDialog,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: const BoxDecoration(
                            color: Color(0xFFCA771A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const UserInfoWidget(),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFCA771A),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                      ..._getDetailConfigs().map((config) {
                      return Column(
                        children: [
                          _buildDetail(config['title'], config['key'], config['icon']),
                          const SizedBox(height: 10.0),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
                 const SizedBox(height: 20.0),
            if (userType == 'farmer') const ServiceInfoWidget(), 
            ],
          ),
        ),
      ),
    );
  }
}
