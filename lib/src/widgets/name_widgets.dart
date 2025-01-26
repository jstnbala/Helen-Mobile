import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Initialize the FlutterSecureStorage
final FlutterSecureStorage storage = FlutterSecureStorage();

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    _checkAccountVerification();
  }

  /// Function to check account verification status
  Future<void> _checkAccountVerification() async {
    String? accountStatus = await storage.read(key: 'status');
    if (accountStatus == 'Verified') {
      setState(() {
        _isVerified = true;
      });
    }
  }

  /// Function to get the username from secure storage
  Future<String?> getUsername() async {
    return await storage.read(key: 'Username');
  }

  /// Function to get the full name from secure storage
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
        const SizedBox(height: 5.0),
        if (!_isVerified)
          _waitingForVerificationRow(), // Show "Waiting for verification" if not verified
      ],
    );
  }

  /// Function to build full name text widget with optional placeholder
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

  /// Function to build the username row, with conditional rendering of the checkmark based on verification status
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
          if (_isVerified) // Only show the checkmark if the account is verified
            const Icon(
              Icons.check_circle,
              color: Color(0xFFCA771A),
              size: 18.0,
            ),
        ],
      ),
    );
  }

  /// Function to build the "Waiting for verification" row
  Widget _waitingForVerificationRow() {
    return const Center(
      child: Text(
        'Waiting for verification...',
        style: TextStyle(
          backgroundColor: Color.fromARGB(255, 252, 244, 170),
          color: Colors.orange,
          fontFamily: 'Poppins',
          fontSize: 12.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
