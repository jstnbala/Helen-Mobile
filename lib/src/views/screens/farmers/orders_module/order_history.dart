// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:helen_app/src/services/post_orders_api.dart';
import 'order_information.dart'; // Adjust the import path as necessary
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late ScrollController _scrollController;
  List<dynamic>? orders; // Variable to store orders
  String? userType;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    fetchOrders(); // Call fetchOrders to retrieve orders
    _getUserType();

  }

  Future<void> fetchOrders() async {
    orders = await getCompletedOrders();
    if (mounted) { // Check if the widget is still mounted before calling setState
      setState(() {}); // Update the UI after fetching orders
    }
  }

    Future<void> _getUserType() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? storedUserType = await secureStorage.read(key: 'UserType');
    setState(() {
      userType = storedUserType;
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(const Color(0xFFCA771A)),
        ),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          thickness: 8.0,
          radius: const Radius.circular(10),
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16.0),
            children: [
              // Header Image
              Center(
                child: Image.asset(
                  'images/farmers/history_header.png',
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              // Check if orders are available
              if (orders == null) ...[
                const Center(child: CircularProgressIndicator()), // Show loading indicator
              ] else if (orders!.isEmpty) ...[
                const Center(child: Text('No pending orders available.')), // Message when no orders
              ] else ...[
                // Display each order
                for (var order in orders!) 
                  buildOrderCard(order),
              ],
            ],
          ),
        ),
      ),
    );
  }

Widget buildOrderCard(dynamic order) {
  return GestureDetector(
    onTap: () {
      // Navigate to OrderInformation page, passing the order data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderInformation(order: order),
        ),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with border radius
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: order['productPic'] ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 16.0),
            // Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Status Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          order['ProductName'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Color(0xFFCA771A),
                          ),
                        ),
                      ),
                      // Check for Completed status
                      if (order['FarmerStatus'] == 'Order Completed' &&
                          order['BuyerStatus'] == 'Order Received')
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00B300), // Mid green background
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            'Completed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      // Check for Canceled status
                      if (order['FarmerStatus'] == 'Canceled' || 
                          order['BuyerStatus'] == 'Canceled')
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEE4B2B), // Red background
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            'Canceled',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  // Farmer Name
                  Row(
                    children: [
                      const Icon(Icons.person, color: Color(0xFFCA771A), size: 16),
                      const SizedBox(width: 4.0),
                      Text(
                        userType == 'farmer' 
                            ? order['BuyerName'] ?? 'N/A' 
                            : order['FarmerName'] ?? 'N/A',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFCA771A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.attach_money, color: Color(0xFFCA771A), size: 16),
                      const SizedBox(width: 4.0),
                      Text(
                        "PHP ${order['Price']}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                    ],
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


}
