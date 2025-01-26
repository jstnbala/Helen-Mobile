// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:helen_app/main.dart';
import 'package:helen_app/src/views/common/navbar.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

class InstiPriceBreakdownScreen extends StatefulWidget {
  final Map<String, dynamic> request;
  final String selectedPaymentOption;
  final String selectedDeliveryOption;
  
  InstiPriceBreakdownScreen({
    required this.request,
    required this.selectedPaymentOption,
    required this.selectedDeliveryOption,
  });

  @override
  _InstiPriceBreakdownScreenState createState() => _InstiPriceBreakdownScreenState();
}

class _InstiPriceBreakdownScreenState extends State<InstiPriceBreakdownScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

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

Future<void> _downloadReceipt() async {
  try {
    // Define the Downloads directory path
    Directory downloadsDir = Directory('/storage/emulated/0/Download');

    // Ensure the Downloads directory exists
    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }

    // Set the full path where the file will be saved
    String filePath = '${downloadsDir.path}/receipt.png';

    // Capture the widget and save it directly to the Downloads directory
    await _screenshotController.captureAndSave(downloadsDir.path, fileName: "receipt.png");

    // Show a notification after saving
    await _showDownloadNotification();

    print('Receipt saved at: $filePath');
  } catch (onError) {
    print('Error capturing receipt: $onError');
  }
}
Future<void> _showDownloadNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'download_channel', // Channel ID
    'Downloads',        // Channel name
    channelDescription: 'Notifications for downloaded files',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Receipt Downloaded',
    'Your receipt has been saved successfully.',
    notificationDetails,
  );
}


  @override
  Widget build(BuildContext context) {
    return  PopScope(
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
            Screenshot(
              controller: _screenshotController,
              child:Container(
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
            ),
                    const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 32.0,
                      ),
                      Column(
  crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start of the column
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Delivery Option',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFFCA771A),
          ),
        ),
        Text(
          widget.selectedDeliveryOption,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
    const SizedBox(height: 20.0), // Space below the row
  ],
),

                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 32.0,
                      ),
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
                                    widget.selectedPaymentOption,
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
            const SizedBox(height: 20.0),

           Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: _downloadReceipt,
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
                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => const NavBar(),
                        ),
                      );
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
    )
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




}
