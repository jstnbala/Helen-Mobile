// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:helen_app/src/services/order_request_api.dart';
import 'package:helen_app/src/views/common/navbar.dart';
import 'package:helen_app/src/views/screens/buyers/institutional-buyers/order_request_module/for_payment_page.dart';
import 'package:helen_app/src/views/screens/buyers/institutional-buyers/order_request_module/insti-orderform.dart';

class HomepageInsti extends StatefulWidget {
  const HomepageInsti({Key? key}) : super(key: key);
  
  @override
  _HomepageInstiState createState() => _HomepageInstiState();
}

class _HomepageInstiState extends State<HomepageInsti> {
  bool _isAcceptedSelected = true;
  bool _isRequestedSelected = false;
  bool _isDropdownExpanded = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderForm()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFCA771A),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Order Request',
                          style: TextStyle(
                            color: Color(0xFFCA771A),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'For large quantities of orders.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Modify the Pending Orders Section
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Pending Orders',
                      style: TextStyle(
                        color: Color(0xFFCA771A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isAcceptedSelected = true;
                                _isRequestedSelected = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isAcceptedSelected ? const Color(0xFFCA771A) : Colors.white,
                              side: const BorderSide(color: Color(0xFFCA771A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'For Payment',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: _isAcceptedSelected ? Colors.white : const Color(0xFFCA771A),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isAcceptedSelected = false;
                                _isRequestedSelected = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isRequestedSelected ? const Color(0xFFCA771A) : Colors.white,
                              side: const BorderSide(color: Color(0xFFCA771A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Requested',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: _isRequestedSelected ? Colors.white : const Color(0xFFCA771A),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
              
              
if (_isRequestedSelected)
  FutureBuilder<List<dynamic>>(
    future: fetchRequests(),  // Use your fetch function here
    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No requests found.'));
      } else {
        // Data exists
        return Column(
          children: snapshot.data!.map((request) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 10.0),
              width: double.infinity, // Maximize the width
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request['BuyerName'] ?? 'No Buyer Name',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  
                  ...List.generate(
                    request['productDetails'].length,
                    (index) {
                      var product = request['productDetails'][index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product: ${product['productName']}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              color: Color(0xFFCA771A),
                            ),
                          ),
                          Text(
                            'Volume: ${product['volume']} ${product['unit']}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              color: Color(0xFFCA771A),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Description: ${request['Description'] ?? 'No Description'}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Status: ${request['Status']}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      }
    },
  )

                  
else if (_isAcceptedSelected)
  FutureBuilder<List<dynamic>>(
    future: fetchRequestsForPayment(),  // Use your fetch function here
    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No requests found.'));
      } else {
        // Data exists
        return Column(
          children: snapshot.data!.map((request) {
            return GestureDetector(
              onTap: () {
                // Navigate to PriceBreakdownScreen with the selected request
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PriceBreakdownScreen(request: request),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 10.0),
                width: double.infinity, // Maximize the width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['BuyerName'] ?? 'No Buyer Name',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    ...List.generate(
                      request['OrderDetails'].length,
                      (index) {
                        var product = request['OrderDetails'][index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${product['farmerName']}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                color: Color(0xFFCA771A),
                              ),
                            ),
                            const Spacer(), // Adds space between farmerName and productName
                            Text(
                              '${product['productName']}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                color: Color(0xFFCA771A),
                              ),
                            ),
                            const Spacer(), // Adds space between productName and volume
                            Text(
                              '${product['volume']} ${product['unit']}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                color: Color(0xFFCA771A),
                              ),
                            ),
                            const SizedBox(height: 4.0), // Add spacing below the row if needed
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }
    },
  )
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