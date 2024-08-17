import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/help-buyer.dart';
import 'package:helen_app/src/views/common/about.dart';
import 'package:helen_app/src/views/common/login.dart';
import 'direct-homepage.dart';
import 'direct-messages.dart';
import 'direct-orderlists.dart';
import 'direct-profile.dart';

class DirectNavbar extends StatefulWidget {
  @override
  _DirectNavbarState createState() => _DirectNavbarState();
}

class _DirectNavbarState extends State<DirectNavbar> {
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
                HomePageBuyer(),
                MessagesPageBuyer(),
                OrdersListsBuyer(),
                ProfilePageBuyer(),
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
        selectedLabelStyle: TextStyle(
          color: selectedColor,
          fontFamily: 'Poppins',
        ),
        unselectedLabelStyle: TextStyle(
          color: unselectedColor,
          fontFamily: 'Poppins',
        ),
        type: BottomNavigationBarType.fixed,
        iconSize: 30, // Adjust the size of the navigation icons
      ),
    );
  }
}

class HalfWhiteDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0), // Adjust the top padding as needed
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width / 2, // Adjust width as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Centering content
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 80.0, // Size of the profile icon
                      color: Colors.grey, // Gray color for the icon
                    ),
                    SizedBox(height: 16.0), // Space between icon and text
                    Text(
                      "Mark Cayabyab",
                      style: TextStyle(
                        color: Color(0xFFCA771A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(height: 8.0), // Space between name and username
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "@markcayabyab17",
                          style: TextStyle(
                            color: Color(0xFFCA771A),
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 4.0), // Space between username and checkmark
                        Container(
                          width: 16.0,
                          height: 16.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFCA771A),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 10.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
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
                    SizedBox(height: 5.0),
                    _drawerItem(
                      context,
                      icon: Icons.help,
                      text: 'Help',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelpBuyerScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 20.0),
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
