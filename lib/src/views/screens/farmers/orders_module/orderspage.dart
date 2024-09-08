// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // Track the selected tab (0 for Pending, 1 for History)
  int selectedIndex = 0;

  // Create a ScrollController
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // Dispose of the ScrollController when the widget is disposed
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
                // Pending Tab
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
                // History Tab
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
          // Body of the page based on selected tab
          Expanded(
            child: selectedIndex == 0
                ? Theme(
                    data: ThemeData(
                      scrollbarTheme: ScrollbarThemeData(
                        thumbColor: WidgetStateProperty.all(const Color(0xFFCA771A)),
                      ),
                    ),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      thickness: 8.0,
                      radius: const Radius.circular(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                          controller: _scrollController,
                          children: [
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: const BorderSide(
                                  color: Color(0xFFCA771A),
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Icon Image (Placeholder)
                                    Container(
                                      width: 115,
                                      height: 150,
                                      color: const Color.fromARGB(255, 251, 223, 191),
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Color(0xFFCA771A),
                                        size: 50,
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.local_grocery_store, // Replace with appropriate icon
                                                color: Color(0xFFCA771A),
                                                size: 20,
                                              ),
                                              SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(
                                                  'Cauliflower',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFCA771A),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.date_range, // Replace with appropriate icon
                                                color: Color(0xFFCA771A),
                                                size: 20,
                                              ),
                                              SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(
                                                  'July 23, 2024 10:04 AM',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12.0,
                                                    color: Color(0xFF606060),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.attach_money, // Replace with appropriate icon
                                                color: Color(0xFFCA771A),
                                                size: 20,
                                              ),
                                              SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(
                                                  'Total: PHP 2500.00',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFCA771A),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person, // Replace with appropriate icon
                                                color: Color(0xFFCA771A),
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8.0),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFCA771A),
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                child: const Text(
                                                  'Direct Buyer',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16.0),
                                          Center(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Implement button action here
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFFCA771A),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
                                              ),
                                              child: const Text(
                                                'Message',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: const BorderSide(
                                  color: Color(0xFFCA771A),
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Icon Image (Placeholder)
                                    Container(
                                      width: 115,
                                      height: 150,
                                      color: const Color.fromARGB(255, 251, 223, 191),
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Color(0xFFCA771A),
                                        size: 50,
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.local_grocery_store, // Replace with appropriate icon
                                                color: Color(0xFFCA771A),
                                                size: 20,
                                              ),
                                              SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(
                                                  'Orange',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFCA771A),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.date_range, // Replace with appropriate icon
                                                color: Color(0xFFCA771A),
                                                size: 20,
                                              ),
                                              SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(
                                                  'July 20, 2024 10:04 AM',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12.0,
                                                    color: Color(0xFF606060),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.attach_money, // Replace with appropriate icon
                                                color: Color(0xFFCA771A),
                                                size: 20,
                                              ),
                                              SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(
                                                  'Total: PHP 12250.00',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFCA771A),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person, // Replace with appropriate icon
                                                color: Color(0xFFCA771A),
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8.0),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFCA771A),
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                child: const Text(
                                                  'Institutional Buyer',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16.0),
                                          Center(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Implement button action here
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFFCA771A),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
                                              ),
                                              child: const Text(
                                                'Message',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Add more cards here if needed
                          ],
                        ),
                      ),
                    ),
                  ):
               Expanded(
                        child: selectedIndex == 1
                            ? Theme(
                                data: ThemeData(
                                  scrollbarTheme: ScrollbarThemeData(
                                    thumbColor: WidgetStateProperty.all(const Color(0xFFCA771A)),
                                  ),
                                ),
                                child: Scrollbar(
                                  controller: _scrollController,
                                  thumbVisibility: true,
                                  thickness: 8.0,
                                  radius: const Radius.circular(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ListView(
                                      controller: _scrollController,
                                      children: [
                                        Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            side: const BorderSide(
                                              color: Color(0xFFCA771A),
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Icon Image (Placeholder)
                                                Container(
                                                  width: 115,
                                                  height: 115,
                                                  color: const Color.fromARGB(255, 251, 223, 191),
                                                  child: const Icon(
                                                    Icons.image_not_supported,
                                                    color: Color(0xFFCA771A),
                                                    size: 50,
                                                  ),
                                                ),
                                                const SizedBox(width: 16.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icons.local_grocery_store,
                                                            color: Color(0xFFCA771A),
                                                            size: 20,
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          Expanded(
                                                            child: Text(
                                                              'Radish',
                                                              style: TextStyle(
                                                                fontFamily: 'Poppins',
                                                                fontSize: 18.0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFFCA771A),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8.0),
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icons.date_range,
                                                            color: Color(0xFFCA771A),
                                                            size: 20,
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          Expanded(
                                                            child: Text(
                                                              'August 24, 2024 10:05 AM',
                                                              style: TextStyle(
                                                                fontFamily: 'Poppins',
                                                                fontSize: 12.0,
                                                                color: Color(0xFF606060),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8.0),
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icons.attach_money,
                                                            color: Color(0xFFCA771A),
                                                            size: 20,
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          Expanded(
                                                            child: Text(
                                                              'Total: PHP 1500.00',
                                                              style: TextStyle(
                                                                fontFamily: 'Poppins',
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFFCA771A),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8.0),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 8.0, vertical: 4.0),
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xFF00CF00), // Green color background
                                                              borderRadius: BorderRadius.circular(12.0),
                                                            ),
                                                            child: const Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.check,
                                                                  color: Colors.white,
                                                                  size: 16,
                                                                ),
                                                                SizedBox(width: 4.0),
                                                                Text(
                                                                  'Completed',
                                                                  style: TextStyle(
                                                                    fontFamily: 'Poppins',
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.white, // Text color white
                                                                  ),
                                                                ),
                                                              ],
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
                                        const SizedBox(height: 16.0),
                                        Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            side: const BorderSide(
                                              color: Color(0xFFCA771A),
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Icon Image (Placeholder)
                                                Container(
                                                  width: 115,
                                                  height: 110,
                                                  color: const Color.fromARGB(255, 251, 223, 191),
                                                  child: const Icon(
                                                    Icons.image_not_supported,
                                                    color: Color(0xFFCA771A),
                                                    size: 50,
                                                  ),
                                                ),
                                                const SizedBox(width: 16.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icons.local_grocery_store,
                                                            color: Color(0xFFCA771A),
                                                            size: 20,
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          Expanded(
                                                            child: Text(
                                                              'Talong',
                                                              style: TextStyle(
                                                                fontFamily: 'Poppins',
                                                                fontSize: 18.0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFFCA771A),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8.0),
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icons.date_range,
                                                            color: Color(0xFFCA771A),
                                                            size: 20,
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          Expanded(
                                                            child: Text(
                                                              'August 25, 2024 1:00 PM',
                                                              style: TextStyle(
                                                                fontFamily: 'Poppins',
                                                                fontSize: 12.0,
                                                                color: Color(0xFF606060),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8.0),
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icons.attach_money,
                                                            color: Color(0xFFCA771A),
                                                            size: 20,
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          Expanded(
                                                            child: Text(
                                                              'Total: PHP 25000.00',
                                                              style: TextStyle(
                                                                fontFamily: 'Poppins',
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFFCA771A),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8.0),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 8.0, vertical: 4.0),
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xFFEE4B2B), // Red color background
                                                              borderRadius: BorderRadius.circular(12.0),
                                                            ),
                                                            child: const Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.cancel,
                                                                  color: Colors.white,
                                                                  size: 16,
                                                                ),
                                                                SizedBox(width: 4.0),
                                                                Text(
                                                                  'Canceled',
                                                                  style: TextStyle(
                                                                    fontFamily: 'Poppins',
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.white, // Text color white
                                                                  ),
                                                                ),
                                                              ],
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
                                        // Add more cards here if needed
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('Order History')), // Replace with your Order History widget
                      ),
                    ),
                  ],
                ),
              );
            }
          }
