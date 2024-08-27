// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CapturePictureScreen extends StatefulWidget {
  const CapturePictureScreen({super.key});

  @override
  _CapturePictureScreenState createState() => _CapturePictureScreenState();
}

class _CapturePictureScreenState extends State<CapturePictureScreen> {
  bool _isCaptured = false;
  ImageProvider? _capturedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    // Request image from camera
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _isCaptured = true;
        _capturedImage = FileImage(File(image .path));
      });
    }
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
                radius: 150,  // Increased radius to make the circle bigger
                backgroundColor: Colors.transparent,
                child: Stack(
                  children: [
                    // Outer border CircleAvatar
                    CircleAvatar(
                      radius: 145,  // Slightly smaller inner circle for the border
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
            ),
          ],
        ),
      ),
    );
  }
}
