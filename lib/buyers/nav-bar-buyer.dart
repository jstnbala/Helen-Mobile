import 'package:flutter/material.dart';
import 'package:helen_app/buyers/help-buyer.dart';
import 'package:helen_app/buyers/login-buyer.dart';
import 'package:helen_app/buyers/previousorders.dart';
import 'homepage-buyer.dart';
import 'messages-buyer.dart';
import 'orderlists-buyer.dart';
import 'profile-buyer.dart';
import 'about-buyer.dart'; // Import the AboutBuyer class

class NavbarBuyer extends StatefulWidget {
  @override
  _NavbarBuyerState createState() => _NavbarBuyerState();
}

class _NavbarBuyerState extends State<NavbarBuyer> {
  int _selectedIndex = 0;

  static const Color selectedColor = Color(0xFF0C7230);
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
                  color: Color(0xFF0C7230),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Buyer's Name",
                      style: TextStyle(
                        color: Color(0xFF0C7230),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(height: 40.0), // Added extra space
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PreviousOrdersBuyer()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.history, color: Color(0xFF0C7230), size: 30.0,),
                          SizedBox(width: 12.0), // Increased spacing
                          Text(
                            'Previous Orders',
                            style: TextStyle(
                              color: Color(0xFF0C7230),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0), // Added extra space
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutBuyer()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Color(0xFF0C7230), size: 30.0,),
                          SizedBox(width: 12.0), // Increased spacing
                          Text(
                            'About',
                            style: TextStyle(
                              color: Color(0xFF0C7230),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0), // Added extra space
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelpBuyerScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.help, color: Color(0xFF0C7230), size: 30.0,),
                          SizedBox(width: 12.0), // Increased spacing
                          Text(
                            'Help',
                            style: TextStyle(
                            color: Color(0xFF0C7230),
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
                        MaterialPageRoute(builder: (context) => LoginPageBuyer()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0C7230),
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
