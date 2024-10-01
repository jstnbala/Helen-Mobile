// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/navbar.dart';

class PriceBreakdownScreen extends StatefulWidget {
  final Map<String, dynamic> request;
  
  PriceBreakdownScreen({
    required this.request,
  });

  @override
  _PriceBreakdownScreenState createState() => _PriceBreakdownScreenState();
}

class _PriceBreakdownScreenState extends State<PriceBreakdownScreen> {
  String? _selectedPaymentOption; // Variable to store selected payment option
  double totalSum = 0.0;
  
  List<String>? get paymentModes => widget.request['paymentOptions']?.cast<String>();

  @override
  void initState() {
    super.initState();
    // Calculate the totalSum once during initState
    totalSum = (widget.request['OrderDetails'] as List).fold(0.0, (sum, product) {
      final price = product['pricePerUnit'] ?? 0.0;
      final quantity = product['volume'] ?? 0;
      return sum + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            // Order details section
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
                  children: (widget.request['OrderDetails'] as List).asMap().entries.map((entry) {
                    int index = entry.key;
                    final product = entry.value;
                    final farmerName = product['farmerName'];
                    final productName = product['productName'] ?? 'Unknown';
                    final price = product['pricePerUnit'] ?? 0.0;
                    final quantity = product['volume'] ?? 0;
                    final total = price * quantity;

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
                          _buildRow('Assigned Farmer', farmerName),
                          _buildRow('Product Name', productName),
                          _buildRow('Price per unit', 'PHP ${price.toStringAsFixed(2)}'),
                          _buildRow('Quantity', '$quantity kg'),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                            height: 32.0,
                          ),
                          _buildRow('Total', 'PHP ${total.toStringAsFixed(2)}'),
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
                              color: Colors.grey,
                              thickness: 1.0,
                              height: 32.0,
                            ),
                            _buildRow(
                              'Sum of the Total',
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
                      ),
                    ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Payment options section
            _buildPaymentOptions(),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_selectedPaymentOption == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please select a payment method.',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                    );
                  } else {
                    // Handle payment confirmation with selected option
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
                    'Confirm Payment',
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

  Widget _buildRow(String title, String value, {TextStyle? style}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: style ?? const TextStyle(fontFamily: 'Poppins'),
        ),
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Container(
   
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
      
          if (paymentModes != null)
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Mode of Payment:",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...paymentModes!.map((mode) => _buildPaymentOptionItem(mode)).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptionItem(String mode) {
    String imagePath;
    if (mode == 'Cash') {
      imagePath = 'images/buyers/cash.jpg';
    } else if (mode == 'GCash') {
      imagePath = 'images/buyers/gcash.png';
    } else if (mode == 'BankTransfer') {
      imagePath = 'images/buyers/bank-transfer.png';
    } else {
      imagePath = ''; // Default case if needed
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPaymentOption = mode;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: _selectedPaymentOption == mode
                ? const Color.fromARGB(10, 202, 119, 26)
                : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: _selectedPaymentOption == mode
                  ? const Color(0xFFCA771A)
                  : Colors.grey,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Image.asset(imagePath, height: 40.0),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  mode,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCA771A),
                  ),
                ),
              ),
              if (_selectedPaymentOption == mode)
                Icon(Icons.check_circle, color: const Color(0xFFCA771A)),
            ],
          ),
        ),
      ),
    );
  }
}
