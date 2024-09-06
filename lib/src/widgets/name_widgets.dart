// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Initialize the FlutterSecureStorage
final FlutterSecureStorage storage = FlutterSecureStorage();

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  Future<String?> getUsername() async {
    return await storage.read(key: 'Username');
  }

  Future<String?> getFullName() async {
    return await storage.read(key: 'FullName');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder<String?>(
          future: getFullName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return buildFullNamePlaceholder();
            } else {
              return buildFullNamePlaceholder(fullName: snapshot.data!);
            }
          },
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
              return _usernameRow('@Username');
            } else {
              return _usernameRow('@${snapshot.data!}');
            }
          },
        ),
      ],
    );
  }

  Widget buildFullNamePlaceholder({String fullName = 'Full Name'}) {
    return Text(
      fullName,
      style: const TextStyle(
        color: Color(0xFFCA771A),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    );
  }

  Widget _usernameRow(String username) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            username,
            style: const TextStyle(
              color: Color(0xFFCA771A),
              fontFamily: 'Poppins',
              fontSize: 18.0,
            ),
          ),
          const SizedBox(width: 8.0),
          const Icon(
            Icons.check_circle,
            color: Color(0xFFCA771A),
            size: 18.0,
          ),
        ],
      ),
    );
  }
}
