import 'package:flutter/material.dart';
import 'package:helen_app/farmers/about-farmer.dart';
import 'package:helen_app/farmers/help-farmer.dart';
import 'package:helen_app/farmers/login.dart';
import 'homepage.dart';
import 'messagespage.dart';
import 'orderspage.dart';
import 'profilepage.dart';
import 'package:helen_app/farmers/addproduct.dart'; // Import the AddProductPage

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
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
                HomePage(),
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
                    CircleAvatar(
                      radius: 50, // Adjust size as needed
                      backgroundImage: AssetImage('images/farmers/farmer-profile.png'), // Replace with the path to your image
                    ),
                    SizedBox(height: 20.0), // Added extra space
                    Text(
                      "Nestor Matimatico",
                      style: TextStyle(
                        color: Color(0xFFCA771A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(height: 8.0), // Space between name and username
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center row contents
                      children: [
                        Text(
                          "@akosiNestor",
                          style: TextStyle(
                            color: Color(0xFFCA771A),
                            fontFamily: 'Poppins',
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(width: 8.0), // Space between username and checkmark
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFFCA771A),
                          size: 18.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 40.0), // Added extra space
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutFarmer()), // Navigate to AboutFarmer
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Color(0xFFCA771A), size: 30.0,),
                          SizedBox(width: 12.0), // Increased spacing
                          Text(
                            'About',
                            style: TextStyle(
                              color: Color(0xFFCA771A),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0), // Added extra space
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelpFarmerScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.help, color: Color(0xFFCA771A), size: 30.0,),
                          SizedBox(width: 12.0), // Increased spacing
                          Text(
                            'Help',
                            style: TextStyle(
                              color: Color(0xFFCA771A),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
