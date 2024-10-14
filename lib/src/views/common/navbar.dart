import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/services/get_notifications_api.dart';
import 'package:helen_app/src/context/socket_context.dart';
import 'package:helen_app/src/views/screens/notifications/farmer-notif.dart';
import 'package:helen_app/src/views/screens/farmers/addproducts_module/addproduct.dart';
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

  const NavBar({Key? key, this.initialIndex = 0}) : super(key: key);

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

  static const Color selectedColor = Color.fromARGB(255, 145, 75, 28);
  static const Color unselectedColor = Colors.white;
 

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _loadUserAndAccountType();
    _loadNotificationCount();
    _connectToSocket();
  }

    Future<void> _connectToSocket() async {
    final socketProvider = useSocketProvider(context);
    
    // Read the userId from secure storage
    String? userId = await storage.read(key: 'id');
    
    if (userId != null && userId.isNotEmpty) {
      // Connect the socket with the userId
      socketProvider.connectSocket(userId);
      print("Socket connected for userId: $userId");
    } else {
      print("No userId found in secure storage.");
    }
  }

  Future<void> _loadUserAndAccountType() async {
    try {
      _userType = await storage.read(key: 'UserType');
      _accountType = await storage.read(key: 'AccountType');
    } catch (e) {
      // Handle errors if necessary
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadNotificationCount() async {
    try {
      final count = await GetNotifications().getNotificationCount();
      setState(() {
        _notificationCount = count;
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

  Future<bool> _onWillPop() async {
    // Exit the application
    return true; // Returning true allows the app to close
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

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const HalfWhiteDrawer(),
        body: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(27),
                    bottomRight: Radius.circular(27),
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
                        size: 27,
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
                          size: 27,
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
        child: Container(
          color: Colors.white, // Set your desired background color here
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
      ),
          ],
        ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 64.0, // Set a fixed height for the BottomAppBar
            margin: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0), // Different margins for x and y axes
            decoration: BoxDecoration(
              color: Colors.transparent, // Set the background color of the BottomAppBar
              borderRadius: BorderRadius.circular(16.0), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 1, // Spread of the shadow
                  blurRadius: 5, // Blur effect for the shadow
                  offset: const Offset(2, 4), // Offset to elevate
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0), // Apply rounded corners here
              child: BottomAppBar(
                color: const Color.fromARGB(255, 201, 129, 52), // Set BottomAppBar color
                shape: const CircularNotchedRectangle(), // Maintain the notched shape
                elevation: 0, // Set elevation to 0 since we handle shadows manually
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home),
                      color: _selectedIndex == 0 ? selectedColor : unselectedColor,
                      iconSize: 27,
                      onPressed: () => _onItemTapped(0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.message),
                      color: _selectedIndex == 1 ? selectedColor : unselectedColor,
                      iconSize: 27,
                      onPressed: () => _onItemTapped(1),
                    ),
                    if (isFarmer)
                      const SizedBox(width: 50),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      color: _selectedIndex == 2 ? selectedColor : unselectedColor,
                      iconSize: 27,
                      onPressed: () => _onItemTapped(2),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      color: _selectedIndex == 3 ? selectedColor : unselectedColor,
                      iconSize: 27,
                      onPressed: () => _onItemTapped(3),
                    ),
                  ],
                ),
              ),
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

      ),
    );
  }
}
