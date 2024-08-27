// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/help-buyer.dart';
import 'package:helen_app/src/views/common/about.dart';
import 'package:helen_app/src/views/common/login.dart';
import 'package:helen_app/src/views/screens/buyers/institutional-buyers/profile_module/insti_profile.dart';
import '../buyers/institutional-buyers/order_request_module/insti-homepage.dart';
import '../buyers/institutional-buyers/messages_module/insti-messages.dart';
import '../buyers/institutional-buyers/orders_module/insti-orderlists.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class InstiNavbar extends StatefulWidget {
  final int initialIndex;

  const InstiNavbar({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _InstiNavbarState createState() => _InstiNavbarState();
}

class _InstiNavbarState extends State<InstiNavbar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // Selected Color for Bottom Nav Bar
  static const Color selectedColor = Color(0xFFCA771A);
  static const Color unselectedColor = Color(0xFF606060);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HalfWhiteDrawer(), // Adding the drawer
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Container(
                  color: const Color(0xFFCA771A),
                  width: double.infinity,
                  height: 150,
                ),
              ),
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Image.asset(
                  'images/farmers/white-helen.png',
                  height: 100,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Open the drawer
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  icon: Stack(
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 30,
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: const Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // Handle notification tap
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                HomepageInsti(),
                MessagesInsti(),
                OrderListsInsti(),
                InstiProfilePage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(
          color: selectedColor,
          fontFamily: 'Poppins',
        ),
        unselectedLabelStyle: const TextStyle(
          color: unselectedColor,
          fontFamily: 'Poppins',
        ),
        type: BottomNavigationBarType.fixed,
        iconSize: 30, // Adjust the size of the navigation icons
      ),
    );
  }
}


class HalfWhiteDrawer extends StatefulWidget {
  const HalfWhiteDrawer({super.key});

  @override
  _HalfWhiteDrawerState createState() => _HalfWhiteDrawerState();
}

class _HalfWhiteDrawerState extends State<HalfWhiteDrawer> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

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
              FutureBuilder<String?>(
                future: getProfilePicture(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return _defaultAvatar();
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _defaultAvatar();
                  } else {
                    return _buildProfilePicture(snapshot.data!);
                  }
                },
              ),
              const SizedBox(height: 20.0),
              FutureBuilder<String?>(
                future: getFullName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildFullNamePlaceholder();
                  } else {
                    return _buildFullNameAndUsername(snapshot.data!);
                  }
                },
              ),
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
                    MaterialPageRoute(builder: (context) => const HelpBuyerScreen()),
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

  Widget _buildProfilePicture(String base64Image) {
    try {
      if (base64Image.startsWith('data:image/')) {
        base64Image = base64Image.split(',').last;
      }
      int mod = base64Image.length % 4;
      if (mod > 0) {
        base64Image += '=' * (4 - mod);
      }
      Uint8List bytes = base64Decode(base64Image);
      return CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey,
        backgroundImage: MemoryImage(bytes),
      );
    } catch (e) {
      return _defaultAvatar();
    }
  }

  Widget _buildFullNamePlaceholder() {
    return const Text(
      'Full Name',
      style: TextStyle(
        color: Color(0xFFCA771A),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    );
  }

  Widget _buildFullNameAndUsername(String fullName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          fullName,
          style: const TextStyle(
            color: Color(0xFFCA771A),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
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
              return _usernameRow('@Username');
            } else {
              return _usernameRow('@${snapshot.data!}');
            }
          },
        ),
      ],
    );
  }

  Widget _defaultAvatar() {
    return const CircleAvatar(
      radius: 50.0,
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.person,
        size: 100.0,
        color: Colors.white,
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