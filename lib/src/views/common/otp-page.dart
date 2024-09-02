// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/Forgot%20Password/create_new_password.dart';
 
class OtpPage extends StatefulWidget {
  const OtpPage({super.key});
 
  @override
  _OtpPageState createState() => _OtpPageState();
}
 
class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFCA771A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'OTP Verification',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Placeholder to balance the center text
                ],
              ),
            ),
            const SizedBox(height: 40),
 
            // OTP Icon
            const Icon(
                Icons.security,
                size: 100,
                color: Color(0xFFCA771A),
            ),
            const SizedBox(height: 20),
 
            // Info Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'We have sent the verification code through SMS. Please check your messages and enter the code.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
 
            // Phone Number Placeholder
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                '+63 **** *** 3744', // Placeholder, will be updated later
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCA771A),
                ),
              ),
            ),
            const SizedBox(height: 20),
 
            // OTP Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center OTP fields
                children: [
                  _buildOtpField(_otpController1),
                  const SizedBox(width: 10), // Less space between boxes
                  _buildOtpField(_otpController2),
                  const SizedBox(width: 10),
                  _buildOtpField(_otpController3),
                  const SizedBox(width: 10),
                  _buildOtpField(_otpController4),
                ],
              ),
            ),
            const SizedBox(height: 20),
 
            // Resend Code Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle resend OTP logic here
                    },
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Color(0xFFCA771A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
 
            // Verify Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA771A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
                  );
                },
                child: const Center(
                  child: Text(
                    'Verify OTP',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Added bottom spacing
          ],
        ),
      ),
    );
  }
 
  // Widget for individual OTP fields
  Widget _buildOtpField(TextEditingController controller) {
    return SizedBox(
      width: 50, // Reduced width for smaller boxes
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFCA771A), // Focused border color
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          counterText: '', // Hide character counter
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
      ),
    );
  }
}