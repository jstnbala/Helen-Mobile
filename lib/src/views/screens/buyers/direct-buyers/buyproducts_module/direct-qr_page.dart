import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helen_app/main.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct_receipt.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:helen_app/src/utils/constants.dart';

class DirectQRPage extends StatelessWidget {
  final String? qrFilePath;
  final String productName;
  final String quantity;
  final String price;
  final String? selectedDeliveryOption;
  final String? selectedPaymentOption;

  const DirectQRPage({
    super.key,
    this.qrFilePath,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.selectedDeliveryOption,
    required this.selectedPaymentOption,
  });

  Future<void> _downloadImage(BuildContext context, String url) async {
    try {
      // Request storage permission
      if (await Permission.storage.request().isGranted ||  await Permission.manageExternalStorage.request().isGranted) {
        // Get the Downloads directory
        Directory downloadsDir = Directory('/storage/emulated/0/Download');

        // Ensure the directory exists
          if (!await downloadsDir.exists()) {
            await downloadsDir.create(recursive: true);
        }

        String filePath = '${downloadsDir.path}/qr_code.png';

        // Start the download
        await Dio().download(url, filePath);

        // Show a confirmation notification
        _showDownloadNotification('Download Complete', 'QR Code downloaded successfully!');

        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR Code downloaded successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission denied.')),
        );
      }
    } catch (e) {
      print('Download error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to download QR Code.')),
      );
    }
  }

  void _showDownloadNotification(String title, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    NotificationConstants.channelId, // Use the constant for Channel ID
    NotificationConstants.channelName, // Use the constant for Channel Name
    channelDescription: NotificationConstants.channelDescription,
    importance: Importance.high,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // notification ID
    title,
    body,
    platformChannelSpecifics,
    payload: 'item x', // Optional, can be used for navigation
  );
}

  @override
  Widget build(BuildContext context) {
    double totalSum = double.tryParse(price) ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCA771A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Back button color
        ),
        centerTitle: true, // Ensure the title is centered
        title: const Text(
          'Payment',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView( // Make the body scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center( // Center the content horizontally
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Product Summary Section
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8), // Light background for the summary
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Product Summary',
                          style: TextStyle(
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
                              '₱ $price',
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
                              '$quantity',
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Space between product summary and QR code
                // Message on top of the image
                if (qrFilePath != null) ...[
                  const Text(
                    'Please Scan QR Code below',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Make the text big
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  const SizedBox(height: 8), // Smaller space between main text and instruction
                  // Small gray text for instructions
                  const Text(
                    'After scanning, confirm your payment to complete the transaction. Thank you!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 14, // Make the text small
                      color: Color.fromARGB(255, 128, 128, 128), // Set text color to gray
                    ),
                  ),
                  const SizedBox(height: 20), // Add space between the text and image
                  // QR Code Image with border radius
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Apply border radius to the image
                    child: Image.network(
                      qrFilePath!,
                      width: double.infinity, // Set width to fill the parent container
                      fit: BoxFit.contain, // Maintain aspect ratio and fit within the width
                    ),
                  ),
                  // Download Button
                 TextButton(
                  onPressed: () {
                    if (qrFilePath != null) {
                      _downloadImage(context, qrFilePath!);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0), // Add vertical padding if needed
                   
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, // Ensure the button size is minimal
                    children: [
                      Icon(
                        Icons.download, // Use the download icon
                        color: Color(0xFFCA771A), // Set icon color
                      ),
                      SizedBox(width: 8), // Add space between icon and text
                      Text(
                        'Download QR Code',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCA771A), 
                          // Color is set in TextButton.styleFrom
                        ),
                      ),
                    ],
                  ),
                ),
                ] else ...[
                  const Text(
                    'Payment will be done physically when product is received.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 16, // Adjust font size if needed
                      color: Color.fromARGB(255, 255, 137, 59), // Set text color
                    ),
                  ),
                ],
                const SizedBox(height: 20), // Add space between the image and button
                // Confirm Payment Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCA771A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Show confirmation dialog
                    _showConfirmationDialog(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          title: const Text(
            'Payment Complete?',
            style: TextStyle(
              color: Color(0xFFCA771A),
              fontWeight: FontWeight.bold,
            ),
          ), // Title color
          content: const Text(
            'Make sure the order details are correct and paid with the right amount.',
            style: TextStyle(color: Colors.black), // Content color
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Color(0xFFCA771A))), // Button color
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFCA771A), // Filled background color
                foregroundColor: Colors.white, // Text color
              ),
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to the DirectReceipt page after confirmation
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DirectReceipt(
                      productName: productName,
                      quantity: quantity,
                      price: price,
                      selectedDeliveryOption: selectedDeliveryOption,
                      selectedPaymentOption: selectedPaymentOption,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
