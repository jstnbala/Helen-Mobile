// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously, unused_import, prefer_const_declarations, avoid_print
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:helen_app/src/views/common/Forgot%20Password/create_new_password.dart';

import 'dart:async';

import 'dart:io';
import 'dart:math'; // For generating OTP
import 'package:helen_app/src/services/api_service.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String userId;
  final String type;

  const OtpPage({
    super.key,
    required this.phoneNumber,
    required this.userId,
    required this.type
  });

 
  @override
  _OtpPageState createState() => _OtpPageState();
}
 

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final TextEditingController _otpController5 = TextEditingController();
  final TextEditingController _otpController6 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  
  final FocusNode _focusNode6 = FocusNode();
  bool _isLoading = false; // Add a loading state

  String _verificationId = '';

  int _remainingSeconds = 60; // Timer countdown in seconds
  Timer? _resendTimer;
  bool _isResendEnabled = false; // Whether the resend button is enabled
  
  @override
  void initState() {
    super.initState();
    _sendOtp();
    // Automatically focus on the first input when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode1);
    });
  }

    @override
  void dispose() {
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _otpController5.dispose();
    _otpController6.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    _resendTimer?.cancel(); // Cancel the timer if the widget is disposed

    super.dispose();
  }

  void _startResendCountdown() {
  setState(() {
    _remainingSeconds = 60;
    _isResendEnabled = false;
  });

  _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
    setState(() {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
      } else {
        _isResendEnabled = true;
        _resendTimer?.cancel(); // Stop the timer when countdown ends
      }
    });
  });
}
  
  void _sendOtp() {
      final phoneNumber =widget.phoneNumber;
      
      if (phoneNumber.isNotEmpty) {
        sendOtp(phoneNumber);
        _startResendCountdown(); // Start the countdown when OTP is sent

      } else {
        print('Phone number is not provided.');
      }
  }

  String _obfuscatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.length < 7) {
      // Handle cases where the phone number is too short or null to obfuscate
      return phoneNumber ?? '';
    }
    String firstPart = phoneNumber.substring(0, 3); // First 3 digits
    String lastPart = phoneNumber.substring(phoneNumber.length - 4); // Last 4 digits
    String middlePart = '*' * (phoneNumber.length - 7); // Replace middle part with asterisks
    return '$firstPart$middlePart$lastPart';
  }
  
  String generateOtp({int length = 6}) {
    final random = Random();
    final otp = List.generate(length, (_) => random.nextInt(10)).join();
    return otp;
  }

  Future<void> sendOtp(String? phoneNumber) async {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    print('Invalid phone number');
    return;
  }

  final otp = generateOtp(); // Generate the OTP
  final message = "Thank you for registering at Helen!"; // Use as a placeholder for the OTP

  // Save OTP for later verification (you might want to store this in a backend or in a secure place)
  _verificationId = otp;

  final response = await http.post(
    Uri.parse('https://api.semaphore.co/api/v4/otp'),  // Use Semaphore's OTP endpoint
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'apikey': 'b95d4ce6dca75dcd54cea894194715f1',  // Your actual API key
      'number': phoneNumber,  // Recipient's phone number
      'message': message,  // The message with %code% placeholder for OTP
      'sendername': 'Helen',  // Optional, your sender name registered with Semaphore
      'code': otp,  // The generated OTP code
    },
  );

  print(response.body);
  if (response.statusCode == 200) {
    // OTP sent successfully
    print('OTP has been sent successfully!');
    // You can display a Snackbar or toast to notify the user
  } else {
    print('Failed to send OTP: ${response.body}');
  }
}



 bool verifyOtp(String enteredOtp) {
    if (enteredOtp == _verificationId) {
      print('OTP verification successful!');
      return true;
    } else {
      print('OTP verification failed!');
      return false;
    }
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                _obfuscatePhoneNumber(widget.phoneNumber), // Placeholder, will be updated later
                textAlign: TextAlign.center,
                style: const TextStyle(
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center OTP fields
            children: [
              _buildOtpField(_otpController1, _focusNode1, _focusNode2), // First field, no prevFocus
              const SizedBox(width: 10),
              _buildOtpField(_otpController2, _focusNode2, _focusNode3, prevFocus: _focusNode1),
              const SizedBox(width: 10),
              _buildOtpField(_otpController3, _focusNode3, _focusNode4, prevFocus: _focusNode2),
              const SizedBox(width: 10),
              _buildOtpField(_otpController4, _focusNode4, _focusNode5, prevFocus: _focusNode3),
              const SizedBox(width: 10),
              _buildOtpField(_otpController5, _focusNode5, _focusNode6, prevFocus: _focusNode4),
              const SizedBox(width: 10),
              _buildOtpField(_otpController6, _focusNode6, FocusNode(), prevFocus: _focusNode5), // Last field, no nextFocus
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
                    onPressed: _isResendEnabled ? () => _sendOtp() : null,
                    child: Text(
                      _isResendEnabled
                        ? 'Resend Code'
                        : 'Resend in $_remainingSeconds sec',
                      style: const TextStyle(
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
                onPressed: _isLoading
                ? null
                : () async {
                   setState(() {
                    _isLoading = true; // Set loading state to true
                  });
                  String otp = _otpController1.text + _otpController2.text + _otpController3.text + _otpController4.text + _otpController5.text + _otpController6.text;
      
                 
                  print('otp: $otp');
                  bool isVerified = await verifyOtp(otp);  
     
                  if (isVerified && mounted ) {
              
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Verification Successful'),
                              content: const Text('Your OTP has been verified successfully!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                        // Navigate to the next page after closing the dialog
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ResetPasswordPage(userId: widget.userId, type: widget.type)),
                                    );
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      
                  }  else if (mounted) {
                          // Show an error message if OTP verification failed
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid OTP, please try again.')),
                      );
                    }

                     setState(() {
                      _isLoading = false; // Reset loading state
                    });
                },
                  
                  child: _isLoading // Show loading indicator when loading
              ? const Row(
                  mainAxisSize: MainAxisSize.min, // Center the content
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2, // Adjust thickness if needed
                    ),
                    SizedBox(width: 10), // Space between spinner and text
                     Center(
                      child: Text(
                        'Verifying...',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                ),
                  ],
                )
              : const Center(
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
  Widget _buildOtpField(
      TextEditingController controller, FocusNode currentFocus, FocusNode nextFocus, {FocusNode? prevFocus}) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
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
        onChanged: (value) {
          if (value.length == 1) {
            // Move focus to the next field if one character is entered
            FocusScope.of(context).requestFocus(nextFocus);
          } else if (value.isEmpty && prevFocus != null) {
            // Move focus back to the previous field if the current one is cleared
            FocusScope.of(context).requestFocus(prevFocus);
          }
        },
      ),
    );
  }
}