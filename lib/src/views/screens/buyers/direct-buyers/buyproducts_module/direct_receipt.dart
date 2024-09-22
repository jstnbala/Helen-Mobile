import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/views/common/navbar.dart';

class DirectReceipt extends StatefulWidget {
  final String farmerName;
  final String productName;
  final String quantity;
  final String price;
  final String? selectedDeliveryOption;
  final String? selectedPaymentOption;

  const DirectReceipt({
    super.key,
    required this.farmerName,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.selectedDeliveryOption,
    required this.selectedPaymentOption,
  });

  @override
  _DirectReceiptState createState() => _DirectReceiptState();
}

class _DirectReceiptState extends State<DirectReceipt> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? buyerFullName;

  @override
  void initState() {
    super.initState();
    _fetchBuyerFullName();
  }

  Future<void> _fetchBuyerFullName() async {
    try {
      String? fullName = await _storage.read(key: 'FullName');
      setState(() {
        buyerFullName = fullName ?? 'N/A';
      });
    } catch (e) {
      print('Error fetching buyer full name: $e');
      setState(() {
        buyerFullName = 'N/A';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalSum = double.tryParse(widget.price) ?? 0.0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.white,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const NavBar()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          title: const Text(
            'Receipt',
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Farmer/Seller Name',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.farmerName,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Buyer Name',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            buyerFullName ?? 'Loading...',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 32.0,
                      ),
                      const Text(
                        'Product Details',
                        style: TextStyle(
                          fontFamily: 'Poppins',
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
                            widget.productName,
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
                            '₱ ${widget.price}',
                            style: const TextStyle(
                              fontFamily: 'Roboto',
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
                            widget.quantity,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 32.0,
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
                            '₱ ${totalSum.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 32.0,
                      ),
                      if (widget.selectedDeliveryOption != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Delivery Option',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCA771A),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              widget.selectedDeliveryOption!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 32.0,
                      ),
                      if (widget.selectedPaymentOption != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Payment Option',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCA771A),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // Display image icon based on selectedPaymentOption
                                    if (widget.selectedPaymentOption == 'Cash')
                                      Image.asset('images/buyers/cash.jpg', width: 24, height: 24),
                                    if (widget.selectedPaymentOption == 'GCash')
                                      Image.asset('images/buyers/gcash.png', width: 24, height: 24),
                                    if (widget.selectedPaymentOption == 'BankTransfer')
                                      Image.asset('images/buyers/bank-transfer.png', width: 24, height: 24),
                                    const SizedBox(width: 8), // Add space between icon and text
                                    Text(
                                      widget.selectedPaymentOption!,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '₱ ${totalSum.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      // Add functionality for download
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCA771A), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    ),
                    icon: const Icon(Icons.download, color: Color(0xFFCA771A)),
                    label: const Text(
                      'Download',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for orders
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                    ),
                    child: const Text(
                      'Orders',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
