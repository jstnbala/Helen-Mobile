// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({super.key});

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
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
    return Scaffold(
      body: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(const Color(0xFFCA771A)),
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
                  'images/farmers/pending_header.png',
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
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
                        child: Image.asset(
                          'images/buyers/tomato.png',
                          width: 120,
                          height: 190,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // Details Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tomatoes Text
                            const Text(
                              "Tomatoes",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Color(0xFFCA771A),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            // Date and Time
                            const Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    color: Color(0xFFCA771A), size: 16),
                                SizedBox(width: 4.0),
                                Expanded(
                                  child: Text(
                                    "July 23, 2024 10:04 AM",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.0,
                                      color: Color(0xFF606060),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            // Total
                            const Row(
                              children: [
                                Icon(Icons.attach_money,
                                    color: Color(0xFFCA771A), size: 16),
                                SizedBox(width: 4.0),
                                Text(
                                  "Total:",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                                SizedBox(width: 4.0),
                                Expanded(
                                  child: Text(
                                    "PHP 2500.00",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      color: Color(0xFFCA771A),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            // Name
                            const Row(
                              children: [
                                Icon(Icons.person, color: Color(0xFFCA771A),
                                    size: 16),
                                SizedBox(width: 4.0),
                                Text(
                                  "Name:",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                                SizedBox(width: 4.0),
                                Expanded(
                                  child: Text(
                                    "Aikhen Patino",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFCA771A),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            // Buyer Type
                            Row(
                              children: [
                                const Icon(Icons.business,
                                    color: Color(0xFFCA771A), size: 16),
                                const SizedBox(width: 4.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 56, 95, 212),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: const Text(
                                    "Direct Buyer",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            // Message Button
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFCA771A)),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Message",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFCA771A),
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
              // Add more orders here
            ],
          ),
        ),
      ),
    );
  }
}
