// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:helen_app/src/services/post_request.dart'; // Ensure to import your API class
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/views/common/navbar.dart';

class PriceBreakdownScreen extends StatelessWidget {
  final String location;
  final String description;
  final List<Map<String, dynamic>> products;

  PriceBreakdownScreen({
    required this.location,
    required this.products,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    double totalSum = 0.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Price Breakdown',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFCA771A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: products.asMap().entries.map((entry) {
                    int index = entry.key;
                    final product = entry.value;
                    final productName = product['product'] ?? 'Unknown';
                    final price = product['price'] ?? 0.0;
                    final quantity = int.tryParse(product['quantity'].toString()) ?? 0;
                    final total = price * quantity;
                    totalSum += total;

                    // Debugging output
                    print('Product Name: $productName, Price: $price, Quantity: $quantity');

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        children: [
                          Text(
                            'Product ${index + 1} Request Computation',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFCA771A),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Product Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                productName,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'PHP ${price.toStringAsFixed(2)}', // Correct display format for price
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$quantity kg',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.grey, // Gray divider line
                            thickness: 1.0,
                            height: 32.0, // Space between content and divider
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'PHP ${total.toStringAsFixed(2)}', // Correct display format for total
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    );
                  }).toList()
                    ..add(
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            const Divider(
                              color: Colors.grey, // Gray divider line
                              thickness: 1.0,
                              height: 32.0, // Space between content and divider
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sum of the Total',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                                Text(
                                  'PHP ${totalSum.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  const storage = FlutterSecureStorage();
                  final String? buyerName = await storage.read(key: 'FullName');
                  // Gather the relevant data to post
                  for (var product in products) {
                    String productName = product['product'] ?? 'Unknown';
                    double price = product['price'] ?? 0.0;
                    int quantity = int.tryParse(product['quantity'].toString()) ?? 0;
                    String unit = product['unit'] ?? 'kg'; // Adjust if necessary

                    // Call the API for each product
                    final success = await PostRequestAPI.postRequest(
                      buyerName: buyerName ?? '',
                      productName: productName,
                      price: price,
                      quantity: quantity,
                      unit: unit,
                      description: description,
                    );

                    if (success) {
                       // Show the dialog after successful request
                      _showOrderRequestedDialog(context);
                
                      // Handle success (e.g., s
                      //how a confirmation dialog)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order Request Submitted Successfully!')),
                      );
                    } else {
                      // Handle failure
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to Submit Order Request.')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA771A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                  child: Text(
                    'Order Request',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
void _showOrderRequestedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Order Requested"),
        content: const Text("Successfully requested your order. Wait for the organization to accept to proceed to payment."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Navigate to the navbar page when "OK" is pressed
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavBar()), // Replace NavBar with your main navigation page class
                (Route<dynamic> route) => false, // Remove all previous routes
              );
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

}
