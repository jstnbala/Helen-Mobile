// ignore_for_file: avoid_print, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final ImagePicker _picker = ImagePicker();

  Future<String?> getProfilePicture() async {
    final profilePicture = await storage.read(key: 'ProfilePicture');
    print("ProfilePicture: $profilePicture");
    return profilePicture;
  }

  Future<String?> getFullName() async {
    final fullName = await storage.read(key: 'FullName');
    print("FullName: $fullName");
    return fullName;
  }

  Future<String?> getUsername() async {
    final username = await storage.read(key: 'Username');
    print("Username: $username");
    return username;
  }

  Future<String?> getRSBSA() async {
    final rsbsaNo = await storage.read(key: 'RSBSA_No');
    print("RSBSA_No: $rsbsaNo");
    return rsbsaNo;
  }

  Future<String?> getAddress() async {
    final address = await storage.read(key: 'Address');
    print("Address: $address");
    return address;
  }

  Future<String?> getContact() async {
    final contact = await storage.read(key: 'Contact');
    print("Contact: $contact");
    return contact;
  }

  Future<String?> getOrganization() async {
    final organization = await storage.read(key: 'Organization');
    print("Organization: $organization");
    return organization;
  }

  Future<void> updateProfilePicture(String imagePath) async {
  final encodedOrganization = Uri.encodeComponent(await getOrganization() ?? '');
  final _id = await storage.read(key: 'id');



  
  final url = 'https://helen-server-lmp4.onrender.com/api/organizations/$encodedOrganization/farmers/$_id';

  try {
    final request = http.MultipartRequest('PUT', Uri.parse(url));

    // Attach the image file directly without base64 encoding
    request.files.add(await http.MultipartFile.fromPath('ProfilePicture', imagePath));

    // Send the request
    final response = await request.send();

    if (response.statusCode == 200) {
      print('image path from update prfile: $imagePath');
      print('Profile picture updated successfully');
      // Optionally, update the locally stored profile picture
      await storage.write(key: 'ProfilePicture', value: imagePath);
      setState(() {}); // Refresh UI
    } else {
      print('Failed to update profile picture: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('An error occurred while updating profile picture: $e');
  }
}



  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      await updateProfilePicture(image.path);
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
                  FutureBuilder<String?>(
  future: getProfilePicture(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      print('Error: ${snapshot.error}');
      return const CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.person,
          size: 100.0,
          color: Colors.white,
        ),
      );
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      print('Profile picture data is empty or null');
      return const CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.person,
          size: 100.0,
          color: Colors.white,
        ),
      );
    } else {
     final imageUrl = snapshot.data!;
      return CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(imageUrl),
      );
    }
  },
),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _showImagePickerDialog,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: 30.0,  // Increased touch area width
                          height: 30.0, // Increased touch area height
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
              FutureBuilder<String?>(
                future: getFullName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text(
                      'Full Name',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24.0,
                        color: Color(0xFFCA771A),
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    String fullName = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24.0,
                            color: Color(0xFFCA771A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        FutureBuilder<String?>(
                          future: getUsername(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '@Username',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        color: Color(0xFFCA771A),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: Color(0xFFCA771A),
                                      child: Icon(
                                        Icons.check,
                                        size: 12.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              String username = snapshot.data!;
                              return Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '@$username',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        color: Color(0xFFCA771A),
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    const CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: Color(0xFFCA771A),
                                      child: Icon(
                                        Icons.check,
                                        size: 12.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    FutureBuilder<String?>(
                                      future: getRSBSA(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                          return const Row(
                                            children: [
                                              Text(
                                                'RSBSA No:',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16.0,
                                                  color: Color(0xFFCA771A),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 4.0),
                                              Text(
                                                'RSBSA_No',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16.0,
                                                  color: Color(0xFFCA771A),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Row(
                                            children: [
                                              const Text(
                                                'RSBSA No:',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16.0,
                                                  color: Color(0xFFCA771A),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                snapshot.data!,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16.0,
                                                  color: Color(0xFFCA771A),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),
              Stack(
                children: [
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
                          'Farmer Information',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Full Name:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<String?>(
                          future: getFullName(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text(
                                'Full Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Address:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<String?>(
                          future: getAddress(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text(
                                'Address',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Contact No:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<String?>(
                          future: getContact(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text(
                                'Contact No',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Organization:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<String?>(
                          future: getOrganization(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text(
                                'Organization',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}