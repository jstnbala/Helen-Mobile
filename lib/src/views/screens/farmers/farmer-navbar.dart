// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/about.dart';
import 'package:helen_app/src/views/common/help-farmer.dart';
import 'package:helen_app/src/views/common/login.dart';
import 'homepage-farmer.dart';
import 'messagespage.dart';
import 'orderspage.dart';
import 'profilepage.dart';
import 'package:helen_app/src/views/screens/farmers/addproduct.dart'; // Import the AddProductPage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:typed_data';


class FarmerNavbar extends StatefulWidget {
  @override
  _FarmerNavbarState createState() => _FarmerNavbarState();
}

class _FarmerNavbarState extends State<FarmerNavbar> {
  int _selectedIndex = 0;

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
      drawer: HalfWhiteDrawer(), // Adding the drawer
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Container(
                  color: Color(0xFFCA771A),
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
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30, // Adjust icon size if needed
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
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 30,
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
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
              children: [
                HomePageFarmer(),
                MessagesPage(),
                OrdersPage(),
                ProfilePage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  color: _selectedIndex == 0 ? selectedColor : unselectedColor,
                  iconSize: 30, // Increased icon size
                  onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                  icon: Icon(Icons.message),
                  color: _selectedIndex == 1 ? selectedColor : unselectedColor,
                  iconSize: 30, // Increased icon size
                  onPressed: () => _onItemTapped(1),
                ),
                SizedBox(width: 50), // Space for the floating button
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: _selectedIndex == 2 ? selectedColor : unselectedColor,
                  iconSize: 30, // Increased icon size
                  onPressed: () => _onItemTapped(2),
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  color: _selectedIndex == 3 ? selectedColor : unselectedColor,
                  iconSize: 30, // Increased icon size
                  onPressed: () => _onItemTapped(3),
                ),
              ],
            ),
          ),
          
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                );
              },
              child: Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFCA771A),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HalfWhiteDrawer extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0), // Adjust the top padding as needed
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width / 2, // Adjust width as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center text horizontally
                  children: [
                    FutureBuilder<String?>(
                      future: getProfilePicture(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          print('Error: ${snapshot.error}');
                          return CircleAvatar(
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
                    SizedBox(height: 20.0), // Added extra space
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
                              color: Color(0xFFCA771A),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
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
                                  color: Color(0xFFCA771A),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
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
                                              color: Color(0xFFCA771A),
                                              fontFamily: 'Poppins',
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Icon(
                                            Icons.check_circle,
                                            color: Color(0xFFCA771A),
                                            size: 18.0,
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
                                              color: Color(0xFFCA771A),
                                              fontFamily: 'Poppins',
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Icon(
                                            Icons.check_circle,
                                            color: Color(0xFFCA771A),
                                            size: 18.0,
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
                  MaterialPageRoute(builder: (context) => HelpFarmerScreen()),
                );
              },
            ),
            const SizedBox(height: 20.0),
            const Divider(), // Line separator
            _drawerItem(
              context,
              icon: Icons.exit_to_app,
              text: 'Logout',
              onTap: () {
                // Handle logout functionality
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
            
            ],
        ),
      ),
    ),
    );
  }
  // Helper method to create drawer items
  Widget _drawerItem(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
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
}