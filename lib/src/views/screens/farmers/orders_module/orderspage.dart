// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'pending_orders.dart';  // Import the Pending Orders widget
import 'order_history.dart';   // Import the Order History widget

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Navigation bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Pending Orders',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 0
                                  ? const Color(0xFFCA771A)
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (selectedIndex == 0)
                          Container(
                            height: 4.0,
                            color: const Color(0xFFCA771A),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Order History',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 1
                                  ? const Color(0xFFCA771A)
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (selectedIndex == 1)
                          Container(
                            height: 4.0,
                            color: const Color(0xFFCA771A),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content based on selected tab
          Expanded(
            child: selectedIndex == 0
                ? const PendingOrders()
                : const OrderHistory(),
          ),
        ],
      ),
    );
  }
}
