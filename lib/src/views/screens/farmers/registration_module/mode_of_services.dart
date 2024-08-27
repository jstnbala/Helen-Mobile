// ignore_for_file: library_private_types_in_public_api, dead_code

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/farmers/registration_module/take_picture.dart';

class ServicesMode extends StatefulWidget {
  const ServicesMode({super.key});

  @override
  _ServicesModeState createState() => _ServicesModeState();
}

class _ServicesModeState extends State<ServicesMode> {
  bool isGcashChecked = false;
  bool isBankTransferChecked = false;
  bool isDeliveryToBuyerChecked = false;
  bool isSpecificAreaChecked = false;
  bool isPickUpChecked = false;
  bool isOtherModeChecked = false;
  bool isCashChecked = false;
  bool isAnyAreaChecked = false;

  // New state variables for the additional options under "Preferred Pick Up"
  bool isPickUpAtFarmChecked = false;
  bool isDesignatedPickUpAreaChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mode of Services',
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
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Farm Location',
                hintText: 'Enter your farm location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                ),
                labelStyle: const TextStyle(fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 30),

            // Mode of Delivery Section
            const Center(
              child: Text(
                'Mode of Delivery:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFFCA771A),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Hi, Farmer! What delivery options do you offer? Please review and confirm the available methods",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Pickup Section
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCA771A)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text(
                      'Preferred Pick Up',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                    ),
                    value: isPickUpChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isPickUpChecked = value ?? false;
                      });
                    },
                  ),
                  if (isPickUpChecked) ...[
                    CheckboxListTile(
                      title: const Text(
                        'Pick up at your farm',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      ),
                      value: isPickUpAtFarmChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isPickUpAtFarmChecked = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text(
                        'Designated pick-up area',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      ),
                      value: isDesignatedPickUpAreaChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isDesignatedPickUpAreaChecked = value ?? false;
                        });
                      },
                    ),
                    if (isDesignatedPickUpAreaChecked)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Please specify pick-up location',
                            hintText: 'Enter pick-up location',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                            ),
                            labelStyle: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Delivery to Buyer Section
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCA771A)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text(
                      'Deliver to Buyer',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                    ),
                    value: isDeliveryToBuyerChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isDeliveryToBuyerChecked = value ?? false;
                      });
                    },
                  ),
                  if (isDeliveryToBuyerChecked) ...[
                    CheckboxListTile(
                      title: const Text(
                        'At any area/location identified by the buyer',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      ),
                      value: isAnyAreaChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isAnyAreaChecked = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text(
                        'Within specific area/location only',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      ),
                      value: isSpecificAreaChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isSpecificAreaChecked = value ?? false;
                        });
                      },
                    ),
                    if (isSpecificAreaChecked)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Please specify up to what area',
                          hintText: 'Enter the specific area',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                          ),
                          labelStyle: const TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Other Mode Section
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCA771A)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text(
                      'Other (Please Specify)',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                    ),
                    value: isOtherModeChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isOtherModeChecked = value ?? false;
                      });
                    },
                  ),
                  if (isOtherModeChecked)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Please specify',
                        hintText: 'Enter your other delivery method',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                        ),
                        labelStyle: const TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Mode of Payment Section
            const Center(
              child: Text(
                'Mode of Payment:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFFCA771A),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Hi, Farmer! What payment methods do you accept? Please check and confirm which ones are available to you",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Payment Methods
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCA771A)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text(
                      'Cash',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                    ),
                    value: isCashChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isCashChecked = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                      'Gcash (Upload QR)',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                    ),
                    value: isGcashChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isGcashChecked = value ?? false;
                      });
                    },
                  ),
                  if (isGcashChecked)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle file upload
                        },
                        icon: const Icon(Icons.upload_file, color: Colors.white),
                        label: const Text(
                          'Kindly Upload your GCASH QR Code Here.',
                          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCA771A),
                        ),
                      ),
                    ),
                  CheckboxListTile(
                    title: const Text(
                      'Bank Transfer (Upload QR)',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                    ),
                    value: isBankTransferChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isBankTransferChecked = value ?? false;
                      });
                    },
                  ),
                  if (isBankTransferChecked)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle file upload
                        },
                        icon: const Icon(Icons.upload_file, color: Colors.white),
                        label: const Text(
                          'Upload your Bank Transfer QR Code Here.',
                          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCA771A),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Next Button
            // Wrap the ElevatedButton with a SizedBox to control the width
            Center(
              child: SizedBox(
                width: double.infinity, // Make the button as wide as possible
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const CapturePictureScreen()), // Replace with your actual LoginPage class
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCA771A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Next',
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
            ),
          ],
        ),
      ),
    );
  }
}
