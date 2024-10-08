// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/about.dart';
import 'package:helen_app/src/views/common/help-farmer.dart';
import 'package:helen_app/src/views/common/login.dart';
import 'package:helen_app/src/views/screens/notifications/farmer-notif.dart';
import '../farmers/homepage-farmer.dart';
import '../farmers/messages_module/messagespage.dart';
import '../farmers/orders_module/orderspage.dart';
import '../farmers/profile_module/profilepage.dart';
import 'package:helen_app/src/views/screens/farmers/addproducts_module/addproduct.dart'; // Import the AddProductPage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FarmerNavbar extends StatefulWidget {
  final int initialIndex; 

  const FarmerNavbar({Key? key, this.initialIndex = 0}) : super(key: key); // Modify constructor

  @override
  _FarmerNavbarState createState() => _FarmerNavbarState();
}

class _FarmerNavbarState extends State<FarmerNavbar> {
  int _selectedIndex = 0;
  

  static const Color selectedColor = Color(0xFFCA771A);
  static const Color unselectedColor = Color(0xFF606060);

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Initialize _selectedIndex with widget.initialIndex
  }

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
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerNotifPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
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

class HalfWhiteDrawer extends StatefulWidget {
  const HalfWhiteDrawer({super.key});

  @override
  _HalfWhiteDrawerState createState() => _HalfWhiteDrawerState();
}

class _HalfWhiteDrawerState extends State<HalfWhiteDrawer> {
  final FlutterSecureStorage storage = FlutterSecureStorage();

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
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return _defaultAvatar();
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _defaultAvatar();
                  } else {
                    return _buildProfilePicture(snapshot.data!);
                  }
                },
              ),
              SizedBox(height: 20.0),
              FutureBuilder<String?>(
                future: getFullName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
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
                    MaterialPageRoute(builder: (context) => HelpFarmerScreen()),
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

  Widget _buildProfilePicture(String imageUrl) {
    try {
  
      return CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(imageUrl),
      );
    } catch (e) {
      return _defaultAvatar();
    }
  }

  Widget _buildFullNamePlaceholder() {
    return Text(
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

  Widget _usernameRow(String username) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            username,
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
        title: Text(
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
              backgroundColor: Color(0xFFCA771A),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: Text(
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
              backgroundColor: Color(0xFFCA771A),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog

              // Ensure navigation happens after the dialog is dismissed
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  Navigator.of(context).popUntil((route) => route.isFirst); // Clear back stack
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
              });
            },
            child: Text(
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