import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/main.dart';
import 'package:helen_app/src/views/common/navbar.dart';
import 'package:screenshot/screenshot.dart';

class ViewReceipt extends StatefulWidget {
  final dynamic order;

  const ViewReceipt({
    super.key,
    required this.order,
    
  });

  @override
  // ignore: library_private_types_in_public_api
  _ViewReceiptState createState() => _ViewReceiptState();
}

class _ViewReceiptState extends State<ViewReceipt> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
    final ScreenshotController _screenshotController = ScreenshotController();

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
    final orderToDisplay =  widget.order;


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          color: Colors.white,
          onPressed: () {
             Navigator.pop(context); // Go back to the previous screen

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
            Screenshot(
            controller: _screenshotController,
            child: Container(
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
                          orderToDisplay["FarmerName"],

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
                          orderToDisplay["BuyerName"],
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
                          orderToDisplay["ProductName"],
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
                          '₱ ${orderToDisplay["Price"]}',
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
                          orderToDisplay["Quantity"].toString(),
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
                          '₱  sum',
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
                    if (orderToDisplay['modeOfDelivery'] != null)
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
                            orderToDisplay['modeOfDelivery']!,
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
                    if (orderToDisplay['modeOfPayment'] != null)
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
                                  if (orderToDisplay['modeOfPayment'] == 'Cash')
                                    Image.asset('images/buyers/cash.jpg', width: 24, height: 24),
                                  if (orderToDisplay['modeOfPayment'] == 'GCash')
                                    Image.asset('images/buyers/gcash.png', width: 24, height: 24),
                                  if (orderToDisplay['modeOfPayment'] == 'BankTransfer')
                                    Image.asset('images/buyers/bank-transfer.png', width: 24, height: 24),
                                  const SizedBox(width: 8), // Add space between icon and text
                                  Text(
                                    orderToDisplay['modeOfPayment']!,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '₱ priuce',
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
            ),
            const SizedBox(height: 20.0),
           
          ],
        ),
      ),
    );
  }
}
