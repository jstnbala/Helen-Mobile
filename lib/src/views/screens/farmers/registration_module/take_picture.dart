// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:helen_app/src/services/api_service.dart';

class CapturePictureScreen extends StatefulWidget {
  final Map<String, String> registrationData;
  final Map<String, dynamic> modeOfServiceData;
  final File? gcashQrFile;
  final File? bankTransferQrFile;

  const CapturePictureScreen({
    super.key,
    required this.registrationData,
    required this.modeOfServiceData,
    this.gcashQrFile,
    this.bankTransferQrFile,
  });

  @override
  _CapturePictureScreenState createState() => _CapturePictureScreenState();
}

class _CapturePictureScreenState extends State<CapturePictureScreen> {
  bool _isCaptured = false;
  ImageProvider? _capturedImage;
  final ImagePicker _picker = ImagePicker();
  File? _capturedImageFile;
 

  Future<void> _pickImage() async {
    // Request image from camera
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _isCaptured = true;
        _capturedImageFile = File(image.path); 
        _capturedImage = FileImage(_capturedImageFile!);
      });
    }
  }

  void _cancelImage() {
    // Reset the state to initial values
    setState(() {
      _isCaptured = false;
      _capturedImage = null;
    });
  }

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
          'Profile Picture',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You're almost finished\nwith your registration, Farmer!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFCA771A),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 24,
                height: 1.2, // line spacing closer
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: CircleAvatar(
                radius: 120,  // Increased radius to make the circle bigger
                backgroundColor: Colors.transparent,
                child: Stack(
                  children: [
                    // Outer border CircleAvatar
                    CircleAvatar(
                      radius: 200,  // Slightly smaller inner circle for the border
                      backgroundColor: Colors.transparent,  // Transparent to show the border
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFCA771A),
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),
                    // Inner CircleAvatar to display the image
                    CircleAvatar(
                      radius: 145,
                      backgroundColor: Colors.transparent,
                      foregroundImage: _isCaptured ? _capturedImage : const AssetImage('images/farmers/photo-farmer.png'),
                      child: !_isCaptured
                          ? Center(
                              child: const Icon(
                                Icons.person,  // Placeholder icon
                                size: 100,
                                color: Colors.grey,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            const Text(
              "Click the button below\nfor you to take\na photo or a selfie",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFCA771A),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                height: 1.2, // line spacing closer
              ),
            ),
            const SizedBox(height: 32.0),
            if (!_isCaptured)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA771A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _pickImage,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Take a Photo',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _cancelImage,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {

                        final sendServiceResult = await sendModeOfServiceData(
                          modeOfServiceData: widget.modeOfServiceData,
                          gcashQrFile: widget.gcashQrFile,
                          bankTransferQrFile: widget.bankTransferQrFile,
                        );

                        print('result $sendServiceResult');
                        // Check if sendServiceResult is not null and was successful
                        if (sendServiceResult != null) {

                          print(widget.registrationData['organization']);

                          final isSuccess = await registerFarmer( 
                            username: widget.registrationData['username'] ?? '',
                            fullName: widget.registrationData['fullName'] ?? '',
                            address: widget.registrationData['address'] ?? '',
                            organization: widget.registrationData['organization'] ?? '',
                            contactNo: widget.registrationData['contactNo'] ?? '',
                            rsbsaNo: widget.registrationData['rsbsaNo'] ?? '',
                            password: widget.registrationData['password'] ?? '',
                            serviceInfo: sendServiceResult,
                            imageFile: _capturedImageFile!,

                          );

                          if (isSuccess) {
                            // Handle success, e.g., navigate to another screen
                            print('Farmer registered successfully.');
                            // Navigate to another screen or show success message
                          } else {
                            // Handle failure, e.g., show an error message
                            print('Failed to register farmer.');
                            // Show an error message to the user
                          }
                        } else {
                          // Handle failure to send mode of service data
                          print('Failed to send mode of service data or response was null.');
                          // Show an error message to the user or handle accordingly
}
                      },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Submit',
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
          ],
        ),
      ),
    );
  }
}

