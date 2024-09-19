import 'package:flutter/material.dart';

class DirectQRPage extends StatelessWidget {
  final String? qrFilePath;

  const DirectQRPage({super.key, this.qrFilePath});

  @override
  Widget build(BuildContext context) {
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
          'QR Code Payment',
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
                // Message on top of the image
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
                if (qrFilePath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Apply border radius to the image
                    child: Image.network(
                      qrFilePath!,
                      width: 300, // Set desired width for the image
                      height: 450, // Set desired height for the image
                      fit: BoxFit.cover, // Fit image within the provided size
                    ),
                  )
                else
                  const Text('No QR Code available'), // Display when no QR code is available
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
                    // Action for Confirm Payment
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
}
