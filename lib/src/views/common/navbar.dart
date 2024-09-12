// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:helen_app/src/services/get_notifications_api.dart'; // Import the GetNotifications class
import 'package:helen_app/src/context/socket_context.dart';

import 'package:helen_app/src/views/screens/notifications/farmer-notif.dart';
import 'package:helen_app/src/views/screens/farmers/addproducts_module/addproduct.dart'; // Import the AddProductPage
import 'package:helen_app/src/widgets/floating_button_widget.dart';
import 'package:helen_app/src/widgets/sidebar_widgets.dart';

import '../screens/farmers/homepage-farmer.dart';
import '../screens/messages_module/messagespage.dart';
import '../screens/farmers/orders_module/orderspage.dart';
import 'profilepage.dart';

import '../screens/buyers/direct-buyers/buyproducts_module/direct-homepage.dart';
import '../screens/buyers/institutional-buyers/order_request_module/insti-homepage.dart';

class NavBar extends StatefulWidget {
  final int initialIndex;

  const NavBar({Key? key, this.initialIndex = 0}) : super(key: key); // Modify constructor

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  String? _userType;
  String? _accountType;
  bool _isLoading = true;
  int _notificationCount = 0;

  final storage = const FlutterSecureStorage();

  static const Color selectedColor = Color(0xFFCA771A);
  static const Color unselectedColor = Color(0xFF606060);

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _loadUserAndAccountType(); // Load user and account type
    _loadNotificationCount(); // Get notification count
  }

  Future<void> _loadUserAndAccountType() async {
    try {
      _userType = await storage.read(key: 'UserType');
      _accountType = await storage.read(key: 'AccountType');
    } catch (e) {
      // Handle errors if necessary
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false once data is loaded
      });
    }
  }

  Future<void> _loadNotificationCount() async {
    try {
      final count = await GetNotifications().getNotificationCount();
      setState(() {
        _notificationCount = count;
        print("notif count $_notificationCount");
      });
    } catch (e) {
      // Handle errors if necessary
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isFarmer = _userType == 'farmer';
    final isDirectBuyer = _accountType == 'Direct Buyer';
    final totalNotif = useNotificationCount(context) + _notificationCount;

    return Scaffold(
      drawer: const HalfWhiteDrawer(),
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
                      size: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
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
                      if (totalNotif > 0)
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
                            child: Center(
                              child: Text(
                                totalNotif.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FarmerNotifPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: isFarmer
                  ? const [
                      HomePageFarmer(),
                      MessagesPage(),
                      OrdersPage(),
                      ProfilePage(),
                    ]
                  : isDirectBuyer
                      ? const [
                          HomePageBuyer(),
                          MessagesPage(),
                          OrdersPage(),
                          ProfilePage(),
                        ]
                      : const [
                          HomepageInsti(),
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
                  icon: const Icon(Icons.home),
                  color: _selectedIndex == 0 ? selectedColor : unselectedColor,
                  iconSize: 30,
                  onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                  icon: const Icon(Icons.message),
                  color: _selectedIndex == 1 ? selectedColor : unselectedColor,
                  iconSize: 30,
                  onPressed: () => _onItemTapped(1),
                ),
                if (isFarmer)
                  const SizedBox(width: 50),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  color: _selectedIndex == 2 ? selectedColor : unselectedColor,
                  iconSize: 30,
                  onPressed: () => _onItemTapped(2),
                ),
                IconButton(
                  icon: const Icon(Icons.person),
                  color: _selectedIndex == 3 ? selectedColor : unselectedColor,
                  iconSize: 30,
                  onPressed: () => _onItemTapped(3),
                ),
              ],
            ),
          ),
          if (isFarmer)
            FloatingActionButtonWidget(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProductPage()),
                );
              },
            ),
        ],
      ),
    );
  }
}
