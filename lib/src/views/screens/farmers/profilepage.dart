import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatelessWidget {
  final FlutterSecureStorage storage = FlutterSecureStorage();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<String?>(
                future: getProfilePicture(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    print('Profile picture data is empty or null');
                    return CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 100.0,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    String base64Image = snapshot.data!;
                    try {
                      if (base64Image.startsWith('data:image/')) {
                        base64Image = base64Image.split(',').last;
                      }
                      int mod = base64Image.length % 4;
                      if (mod > 0) {
                        base64Image += '=' * (4 - mod);
                      }
                      Uint8List bytes = base64Decode(base64Image);
                      print('Decoded image bytes length: ${bytes.length}');
                      return CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.grey,
                        backgroundImage: MemoryImage(bytes),
                      );
                    } catch (e) {
                      print('Failed to decode base64 image: $e');
                      return CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 100.0,
                          color: Colors.white,
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 10.0),
              FutureBuilder<String?>(
                future: getFullName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text(
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
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24.0,
                            color: Color(0xFFCA771A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        FutureBuilder<String?>(
                          future: getUsername(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(
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
                            }
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 20.0),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFCA771A),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Farmer Information',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
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
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Text(
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
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        Text(
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
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Text(
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
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        Text(
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
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Text(
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
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        Text(
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
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Text(
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
                                style: TextStyle(
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
                  Positioned(
                    right: 10.0,
                    top: 10.0,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 24.0,
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
