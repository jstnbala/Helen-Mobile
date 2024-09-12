// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width to use it in your layout calculations
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        thickness: 6.0,
        radius: const Radius.circular(10.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Header Image
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'images/farmers/history_header.png',
                    width: screenWidth * 0.9, // Make the image responsive
                  ),
                ),
              ),
              // Order History Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Small icon image (carrots.png) with border radius
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0), // Apply border radius
                          child: Image.asset(
                            'images/farmers/carrots.png',
                            width: 120.0,
                            height: 120.0,
                            fit: BoxFit.cover, // Ensures the image covers the container area
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        // Order Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Name
                              const Text(
                                "Carrots",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Color(0xFFCA771A),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Date and Time
                              const Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Color(0xFFCA771A),
                                    size: 16.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    "November 24, 2024 10:05 AM",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.0,
                                      color: Color(0xFF606060),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              // Total
                              const Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: Color(0xFFCA771A),
                                    size: 16.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Total:",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFCA771A),
                                    ),
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    "PHP 1500.00",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      color: Color(0xFFCA771A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              // Status
                              Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFFCA771A),
                                    size: 16.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    "Status:",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFCA771A),
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: const Text(
                                      "Completed",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
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
              ),
              // You can add more order history cards below in a similar manner
            ],
          ),
        ),
      ),
    );
  }
}
