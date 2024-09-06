// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/widgets/profile_widgets.dart';
import 'package:helen_app/src/widgets/name_widgets.dart';

import 'package:helen_app/src/views/common/about.dart';
import 'package:helen_app/src/views/common/help-farmer.dart';
import 'package:helen_app/src/views/common/login.dart';

class HalfWhiteDrawer extends StatefulWidget {
  const HalfWhiteDrawer({super.key});

  @override
  _HalfWhiteDrawerState createState() => _HalfWhiteDrawerState();
}

class _HalfWhiteDrawerState extends State<HalfWhiteDrawer> {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getProfilePicture() async {
    return await storage.read(key: 'ProfilePicture');
  }

  Future<String?> getFullName() async {
    return await storage.read(key: 'FullName');
  }

  Future<String?> getUsername() async {
    return await storage.read(key: 'Username');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfilePictureWidget(),
              const SizedBox(height: 20.0),
              const UserInfoWidget(),
              const SizedBox(height: 20.0),
              _drawerItem(
                context,
                icon: Icons.info,
                text: 'About',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              const SizedBox(height: 5.0),
              _drawerItem(
                context,
                icon: Icons.help,
                text: 'Help',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpFarmerScreen()),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              const Divider(),
              _drawerItem(
                context,
                icon: Icons.exit_to_app,
                text: 'Logout',
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _drawerItem(BuildContext context,
      {required IconData icon, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFCA771A), size: 30.0),
            const SizedBox(width: 12.0),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFFCA771A),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Do you want to Logout?",
          style: TextStyle(
            color: Color(0xFFCA771A),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFCA771A),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFCA771A),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog

              // Ensure navigation happens after the dialog is dismissed
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  Navigator.of(context).popUntil((route) => route.isFirst); // Clear back stack
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              });
            },
            child: const Text(
              "Confirm",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
}